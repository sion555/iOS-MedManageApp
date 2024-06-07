const Sequelize = require('sequelize');
const { Hooks } = require('sequelize/lib/hooks');

class Receipt extends Sequelize.Model {
  static init(sequelize) {
    
    return super.init(
      { 
        userID: {
            type: Sequelize.STRING(50),
            allowNull: false,
        },
        ReceiptID: {
            type: Sequelize.INTEGER,
            allowNull: false,
            primaryKey: true,
            autoIncrement: true,
        },
        prescriptionID: {
            type: Sequelize.INTEGER,
            allowNull: false,
            primaryKey: true,
        },
        receiptNumber: {
            type: Sequelize.STRING(50),
        },
        totalPillExpense: {
            type: Sequelize.INTEGER,
        },
        personalExpense : {
            type : Sequelize.INTEGER,
        },
        insuranceExpense : {
            type : Sequelize.INTEGER,
        },
        nonCoveredExpense : {
            type : Sequelize.INTEGER,
        },
        cardPayment : {
            type : Sequelize.INTEGER,
        },
        cashPayment : {
            type : Sequelize.INTEGER,
        },
        cashReceipt : {
            type : Sequelize.INTEGER,
        },
        totalPayment : {
          type : Sequelize.INTEGER,
        },
        pharmacyName: {
            type: Sequelize.STRING(100),
        },
        hospitalName: {
            type: Sequelize.STRING(100),
        },
      },
      {
        sequelize,
        timestamps: true,
        paranoid: true,
        modelName: 'Receipt',
        tableName: 'receipt',
      },
    );
  }
  static associate(db) {
    db.Receipt.belongsTo(db.User, { foreignKey: 'userID', sourceKey: 'userID' });
    db.Receipt.hasOne(db.Prescription, { foreignKey: 'prescriptionID', sourceKey: 'prescriptionID', delete: 'CASCADE', hooks: true});
  }
}

module.exports = Receipt;