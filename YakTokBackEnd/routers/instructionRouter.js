const express = require('express');
const { Instructions } = require('../models/index');
const router = express.Router();
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const secret = process.env.JWT_SECRET;

router.post('/', async (req, res) => {
    const newInstruction = req.body;
    newInstruction.userID = req.body.userID;
    newInstruction.pillID = req.body.pillID;
    newInstruction.instruction = req.body.instruction;
    newInstruction.instructionDate = req.body.instructionDate;
    try {
        const result = await Instructions.create(newInstruction);
        res.json({ success: true, instruction: [result], message: '처방 추가 성공' });
    } catch (error) {
        console.error(error);
        res.json({ success: false, instruction: [], message: '처방 추가 실패' });
    }
}
);