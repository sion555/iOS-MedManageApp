const Sequelize = require('sequelize');
const { Hooks } = require('sequelize/lib/hooks');

class Receipt extends Sequelize.Model {
  static init(sequelize) {
    
    return super.init(
      { 
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
        totalAmount: {
            type: Sequelize.INTEGER,
        },
        personalExpense : {
            type : Sequelize.INTEGER,
        },
        insuranceExpense : {
            type : Sequelize.INTEGER,
        },
        prescriptionDate: {
            type: Sequelize.DATE,
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
    db.Receipt.hasOne(db.Prescription, { foreignKey: 'prescriptionID', sourceKey: 'prescriptionID', delete: 'CASCADE', hooks: true});
  }
}

module.exports = Receipt;