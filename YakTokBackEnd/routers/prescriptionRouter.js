const express = require('express');
const { Prescription, Receipt } = require('../models/index');
const router = express.Router();
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const secret = process.env.JWT_SECRET;
const { where } = require('sequelize');
const receipt = require('../models/receipt');


router.get('/', async (req, res) => {
    try {
        const result = await Prescription.findAll();
        res.json({ success: true, prescription: [result], message: '처방 조회 성공' });
    } catch (error) {
        console.error(error);
        res.json({ success: false, prescription: [], message: '처방 조회 실패' });
    }
});

router.delete('/:prescriptionID', async (req, res) => {
    const prescriptionID = req.params.prescriptionID;
    const options = {
      where: {
        prescriptionID: prescriptionID,
      },
    };
    try {
        const prescriptionResult = await Prescription.destroy(options);
        const receiptResult = await Receipt.destroy(options);
      if (prescriptionResult && receiptResult) {
        res.json({ success: true, message: '처방 삭제 성공' });
      } else {
        res.json({ success: false, message: '처방 삭제 실패, 해당 처방이 없습니다.' });
      }
    } catch (error) {
      console.error(error);
      res.json({ success: false, message: '처방 삭제 실패', error });
    }
  });
  
  



module.exports = router;
