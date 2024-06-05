const express = require('express');
const { Receipt } = require('../models/index');
const router = express.Router();
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const secret = process.env.JWT_SECRET;

router.post('/', async (req, res) => {
    const newReceipt = req.body;
    newReceipt.prescriptionID = req.body.prescriptionID;
    newReceipt.totalAmount = req.body.totalAmount;
    newReceipt.personalExpense = req.body.personalExpense;
    newReceipt.insuarenceExpense = req.body.insuarenceExpense;
    try {
        const result = await Receipt.create(newReceipt);
        res.json({ success: true, receipt: [result], message: '영수증 추가 성공' });
    } catch (error) {
        console.error(error);
        res.json({ success: false, receipt: [], message: '영수증 추가 실패' });
    }
});

module.exports = router;