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
    const { password, userID, userName } = req.body;
    if (password === ""||userID === ""||userName === "") {
        return res.status(400).json({ success: false, message: '유저 정보를 전부 입력해주세요' });
    }
    
    if (!password||!userID||!userName) {
    return res.status(400).json({ success: false, message: '서버에 문제가 있습니다' });
  }
  
  
  try {
    const existingUser = await User.findOne({ where: { userID: userID } });
    if (existingUser) {
        return res.status(400).json({ success: false, message: '동일한 ID가 이미 존재합니다.' });
    }

    const hashedPassword = await createHash(password, 10);
    console.log(password);
    password = hashedPassword;
    const result = await User.create(member);
    res.json({ success: true, member: result, message: '멤버 추가 성공' });
    }catch (err) {
    console.error(err);
    return res.status(500).json({ success: false, member: [], message: err.message });
  }
});

router.post('/sign-in', async (req, res) => {
    const { userID, password } = req.body;

    if (!userID || !password ) {
        return res.status(400).json({
            success: false,
            message: '서버에 문제가 있습니다 다시 시도해주세요'
        });
    }
    if (userID.trim() === '' || password.trim() === '') {
        return res.status(400).json({
            success: false,
            message: '아이디와 비밀번호를 입력해주세요'
        });
    }

    try {
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
} catch (error) {
    console.error(error);
    res.status(500).json({ success: false, token: '', message: error.message });
}
});

router.get('/search', isAuth, async (req, res) => {
    const { userID } = req.query;

    if (!userID || userID.trim() === '') {
        return res.status(400).json({ success: false, member: [], message: '다시 로그인해주세요' });
    }
    const options = {
        where: { userID: userID },
        include: [
            { 
                model: Prescription, 
                as: 'Prescriptions',
                include: [
                    { model: Receipt, as: 'Receipt' },
                    { 
                        model: Instruction, 
                        as: 'Instructions', 
                        include: [
                            { model: Pill, as: 'Pill' }
                        ]
                    },
                ]
            },
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