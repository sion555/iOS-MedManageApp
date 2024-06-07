const express = require('express');
const { Pill, Prescription, Receipt, User, Instruction } = require('../models/index');
const router = express.Router();
const { Sequelize } = require('sequelize');
const env = process.env.NODE_ENV || 'development';
const config = require('../config/config.json')[env];
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const secret = process.env.JWT_SECRET;
const sequelize = new Sequelize(
    config.database,
    config.username,
    config.password,
    config
  );

const upload = require('./uploadImage');
const { where } = require('sequelize');
router.post('/', upload.single('photo'));

router.post('/', async (req, res) => {
    let transaction;
    try {
        transaction = await sequelize.transaction(); // 트랜잭션 시작

        const { pill: bulkPill, prescriptionID: initialPrescriptionID, 
            userID, 
            hospitalName, 
            prescriptionDate, 
            totalPillExpense,
            nonCoveredExpense,
            cardPayment,
            personalExpense, 
            cashPayment,
            totalPayment,
            receiptNumber,
            pharmacyName,
            insuranceExpense } = req.body;

        if (!userID || !hospitalName || !prescriptionDate) {
            throw new Error('필수 정보가 누락되었습니다.');
        }

        let prescriptionID = initialPrescriptionID;
        if (!prescriptionID) {
            const newPrescription = await Prescription.create({
                userID,
                hospitalName,
                prescriptionDate,
            }, { transaction });
            prescriptionID = newPrescription.prescriptionID;
        }

        let receipt = await Receipt.findOne({ where: { prescriptionID } });
        if (!receipt) {
            receipt = await Receipt.create({
                prescriptionID,
                userID,
                totalPillExpense,
                nonCoveredExpense,
                cardPayment,
                cashPayment,
                totalPayment,
                receiptNumber,
                personalExpense,
                insuranceExpense,
                prescriptionDate,
                pharmacyName,
                hospitalName,
            }, { transaction });
        }

        if (!Array.isArray(bulkPill)) {
            bulkPill = bulkPill ? [bulkPill] : [];
        }

        const uniqueNames = new Set();
        const duplicates = bulkPill.filter(pill => !uniqueNames.has(pill.pillName) && !uniqueNames.add(pill.pillName));
        if (duplicates.length > 0) {
            throw new Error('중복된 약 이름이 있습니다.');
        };

        const pillResults = await Pill.bulkCreate(bulkPill.map(pill => ({
            ...pill,
            prescriptionID
        })), { transaction });

        const instructions = pillResults.map(pill => ({
            prescriptionID,
            pillID: pill.pillID,
            pillName: pill.pillName,
            instruction: pill.instruction || ''
        }));

        await Instruction.bulkCreate(instructions, { transaction });

        await transaction.commit();
        res.json({ success: true, pill: pillResults, message: '약 추가 성공' });
    } catch (error) {
        if (transaction) await transaction.rollback();
        console.error("트랜잭션 처리 실패: ", error);
        res.status(500).json({ success: false, message: error.message });
    }
});


router.get('/:id', async (req, res) => {
    const id = req.params.id;
    const options = {
        where: { 
            pillID: id 
        },
    }
    try {
        const result = await Pill.findAll(options);
        if (result.length == 0) {
            throw new Error('약이 존재하지 않음');
        }
        res.json({ success: true, pill: [result], message: '약 조회 성공' });
    } catch (error) {
        console.error(error);
        res.json({ success: false, pill: [], message: '약 조회 실패' });
    }
});

module.exports = router;