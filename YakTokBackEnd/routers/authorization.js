const jwt = require('jsonwebtoken');
const secret = process.env.JWT_SECRET;

const isAuth = async (req, res, next) => {
    const auth = req.get('Authorization');

    if (!auth || !auth.startsWith('Bearer ')) {
        return res.status(401).json({ success: false, message: '인증이 필요합니다.' });
    }

    const token = auth.split(' ')[1];

    jwt.verify(token, secret, (err, decoded) => {
        if (err) {
            return res.status(401).json({ success: false, message: '토큰이 만료되었습니다.' });
        } else {
            req.userID = decoded.uid;
            req.role = decoded.rol;
            next();
        }
    });
};

module.exports = isAuth;