const Sequelize = require('sequelize');
const process = require('process');
const env = process.env.NODE_ENV || 'development';
const config = require('../config/config.json')[env];

const db = {};

let sequelize = new Sequelize(
  config.database,
  config.username,
  config.password,
  config
);

const User = require('./user');
const Pill = require('./pill');
const Prescription = require('./prescription');
const Receipt = require('./receipt');

db.User = User;
db.Pill = Pill;
db.Prescription = Prescription;
db.Receipt = Receipt;

User.init(sequelize);
Pill.init(sequelize);
Prescription.init(sequelize);
Receipt.init(sequelize);

User.associate(db);
Pill.associate(db);
Prescription.associate(db);
Receipt.associate(db);

db.sequelize = sequelize;
db.Sequelize = Sequelize;

module.exports = db;
