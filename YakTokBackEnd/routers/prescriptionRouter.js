const express = require('express');
const { Prescription, Receipt, Pill } = require('../models/index');
const router = express.Router();
const { Sequelize } = require('sequelize');
const bcrypt = require('bcrypt');
const env = process.env.NODE_ENV || 'development';
const config = require('../config/config.json')[env];
const jwt = require('jsonwebtoken');
const secret = process.env.JWT_SECRET;
const { where } = require('sequelize');
const receipt = require('../models/receipt');
const sequelize = new Sequelize(
  config.database,
  config.username,
  config.password,
  config
);


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

  const transaction = await sequelize.transaction(); 
  try {
      const options = {
          where: { prescriptionID: prescriptionID },
          transaction: transaction
      };
      
      const prescriptionResult = await Prescription.destroy(options);

      if (prescriptionResult === 0) {
          await transaction.rollback();
          return res.json({ success: false, message: '처방 삭제 실패, 해당 처방이 없습니다.' });
      }

      await transaction.commit(); 
      res.json({ success: true, message: '처방 삭제 성공' });
  } catch (error) {
      await transaction.rollback(); 
      console.error("처방 삭제 중 에러 발생: ", error);
      res.status(500).json({ success: false, message: '처방 삭제 실패', error: error.message });
  }
});

  
  

// router.post('/', async (req, res) => {
//     let bulkPrescription = req.body.prescription;

//     if (!Array.isArray(bulkPrescription)) {
//         bulkPrescription = bulkPrescription ? [bulkPrescription] : [];
//     }

//     bulkPrescription = bulkPrescription.map((prescription) => {
//         prescription.userID = req.body.userID;
//         return prescription;
//     });

//     try {
//         const result = await Prescription.bulkCreate(bulkPrescription);
//         res.json({ success: true, prescription: result, message: '처방 추가 성공' });
//         console.log(result);
//     } catch (error) {
//         console.error(error);
//         res.json({ success: false, prescription: [], message: '처방 추가 실패' });
//     }
// });



module.exports = router;
