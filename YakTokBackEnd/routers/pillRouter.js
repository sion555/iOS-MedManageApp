const express = require('express');
const { Pill, Prescription, Receipt } = require('../models/index');
const router = express.Router();
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const secret = process.env.JWT_SECRET;

const upload = require('./uploadImage');
const { where } = require('sequelize');
router.post('/', upload.single('photo'));

router.post('/', async (req, res) => {
    let bulkPill = req.body.pill;
    let prescriptionID = req.body.prescriptionID;

    if (!prescriptionID)    {
        try {
            const newPrescription = await Prescription.create({
                userID: req.body.userID,
                hospitalName: req.body.hospitalName,
                prescriptionDate: req.body.prescriptionDate,
            });
            prescriptionID = newPrescription.prescriptionID;
        }
        catch (error) {
            console.error("처방 생성 실패: ", error);
            return res.status(500).json({ success: false, message: '처방 생성 실패' });
        }
    }
    try {
        let receipt = await Receipt.findOne({ where: { prescriptionID: prescriptionID } });
        if (!receipt) {
            receipt = await Receipt.create({ 
                prescriptionID: prescriptionID,
                totalAmount: req.body.totalAmount,
                personalExpense: req.body.personalExpense,
                insuranceExpense: req.body.insuranceExpense,
                prescriptionDate: req.body.prescriptionDate,
            });
        }
    }
    catch (error) {
        console.error("영수증 생성 실패: ", error);
        return res.status(500).json({ success: false, message: '영수증 생성 실패' });
    }
    if (!Array.isArray(bulkPill)) {
        bulkPill = bulkPill ? [bulkPill] : [];
    }

    const uniqueNames = new Set();
    const duplicates = bulkPill.filter(pill => {
        if (uniqueNames.has(pill.pillName)) {
            return true;
        }
        uniqueNames.add(pill.pillName);
        return false;
    
    });
    if (duplicates.length > 0) {
        return res.status(400).json({ success: false, message: '중복된 약 이름이 있습니다.' });
    };

    bulkPill = bulkPill.map((pill) => {
        pill.prescriptionID = req.body.prescriptionID;
        return pill;
    });

    try {
        const result = await Pill.bulkCreate(bulkPill);
        res.json({ success: true, pill: result, message: '약 추가 성공' });
        console.log(result);
    } catch (error) {
        console.error(error);
        res.json({ success: false, pill: [], message: '약 추가 실패' });
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