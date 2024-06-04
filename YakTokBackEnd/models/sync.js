const { sequelize } = require('./index.js');

const sync = () => {
    sequelize
        .sync({ force: true, alter: true })
        .then(() => console.log('데이터베이스 생성 완료'))
        .catch((err) => {
            console.error(err)
    });
};

module.exports = sync;