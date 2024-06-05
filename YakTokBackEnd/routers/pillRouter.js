const express = require('express');
const { Pill } = require('../models/index');
const router = express.Router();
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const secret = process.env.JWT_SECRET;

const upload = require('./uploadImage');
const { where } = require('sequelize');
router.post('/', upload.single('photo'));

router.post('/', async (req, res) => {
    let bulkPill = req.body.pill;

    if (!Array.isArray(bulkPill)) {
        bulkPill = bulkPill ? [bulkPill] : [];
    }

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