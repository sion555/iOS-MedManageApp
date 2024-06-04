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
    const newPill = req.body;
    newPill.pillName = req.body.pillName;
    newPill.pillImage = req.filename;
    newPill.pillDescription = req.body.pillDescription;
    newPill.pillType = req.body.pillType;
    newPill.storageMethod = req.body.storageMethod;
    newPill.medicineEffect = req.body.medicineEffect;
    console.log(newPill);
    try {
        const result = await Pill.create(newPill);
        console.log(result);
        result.price = parseInt(result.price);
        res.json({ success: true, pill: [result], message: '약 추가 성공' });
    } catch (error) {
        console.error(error);
        res.json({ success: false, pill: [], message: "약 추가 실패" });
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