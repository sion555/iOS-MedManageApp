const express = require('express');
const { User } = require('../models/index');
const router = express.Router();
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const Pill = require('../models/pill');
const Prescription = require('../models/prescription');
const Receipt = require('../models/receipt');
const Instruction = require('../models/instruction');
const isAuth = require('./authorization');

const secret = process.env.JWT_SECRET;

const createHash = async (password, saltRound) => {
    let hashed = await bcrypt.hash(password, saltRound);
    console.log(hashed);
    return hashed;
};

router.post('/sign-up', async (req, res) => {
  const member = req.body;
  if (!member.password) {
    return res.status(400).json({ success: false, message: 'Password is required' });
  }
  const existingUser = await User.findOne({ where: { userID: member.userID } });
  if (existingUser) {
    return res.status(400).json({ success: false, message: 'A user with this ID already exists' });
  }

  const password = await createHash(member.password, 10);
  console.log(password);
  member.password = password;
  try {
    const result = await User.create(member);
    res.json({ success: true, member: result, message: '멤버 추가 성공' });
  } catch (err) {
    res.json({ success: false, member: [], message: err.message });
  }
});

router.post('/sign-in', async (req, res) => {
    const { userID, password } = req.body;
    const options = {
        attributes: ['password', 'userID'],
        where: { userID: userID },
    };

    const result = await User.findOne(options);
    if (result) {
        const compared = await bcrypt.compare(password, result.password);
        if (compared) {
            const token = jwt.sign({ uid: result.userID, rol: 'user' }, secret);
            res.json({ 
                success: true, 
                token: token, 
                member: {
                userID: result.userID,
                userName: result.userName,
            }, 
            message: '로그인 성공',
            });
        } else {
            res.json({ 
                success: false, 
                token: '', 
                message: '로그인 정보를 다시 확인하세요.'
            });
        }
    }
});

router.get('/search', isAuth, async (req, res) => {
    const { userID } = req.query;
    const options = {
        where: { userID: userID },
        include: [
            { model: Prescription, as: 'Prescriptions',
                include: [
                    { model: Pill, as: 'Pills' },
                    { model: Receipt, as: 'Receipt' },
                ],},
        ],
    };
    try {
        const result = await User.findOne(options); 
        if (result) { 
            res.json({ success: true, member: result, message: '멤버 조회 성공' });
        } else { 
            res.json({ success: false, member: [], message: '멤버를 찾을 수 없습니다.' });
        }
    } catch (error) {
        console.error(error);
        res.json({ success: false, member: [], message: '멤버 조회 실패' });
    }
});
module.exports = router;