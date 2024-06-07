const Sequelize = require('sequelize');
const Instruction = require('./instruction');

class Prescription extends Sequelize.Model {
  static init(sequelize) {
    return super.init(
      {
        userID: {
            type: Sequelize.STRING(50),
            allowNull: false,
        },
        prescriptionID: {
            type: Sequelize.INTEGER,
            allowNull: false,
            primaryKey: true,
            autoIncrement: true,
        },
        hospitalName: {
            type: Sequelize.STRING(100),
        },
        prescriptionStartDate: {
            type: Sequelize.DATE,
        },
        prescriptionEndDate: {
            type: Sequelize.DATE,
        },
      },
      {
        sequelize,
        timestamps: true,
        paranoid: true,
        modelName: 'Prescription',
        tableName: 'prescription',
        indexes: [{ unique: true, fields: ['userID','prescriptionID'] }],
      }
    );
  }

  static associate(db) {
    db.Prescription.belongsTo(db.User, { foreignKey: 'userID', sourceKey: 'userID' });
    db.Prescription.hasOne(db.Receipt, { foreignKey: 'prescriptionID', targetKey: 'prescriptionID', onDelete: 'CASCADE', hooks: true});
    db.Prescription.belongsToMany(db.Pill, { through: db.Instruction, foreignKey: 'prescriptionID', sourceKey: 'prescriptionID' });
    db.Prescription.hasMany(db.Instruction, { foreignKey: 'prescriptionID', sourceKey: 'prescriptionID' });
  }
}

module.exports = Prescription;