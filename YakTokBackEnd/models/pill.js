const Sequelize = require('sequelize');
const Instruction = require('./instruction');

class Pill extends Sequelize.Model {
  static init(sequelize) {
    return super.init(
       {
        pillID: {
          type: Sequelize.INTEGER,
          allowNull: false,
          primaryKey: true,
          autoIncrement: true,
        },
        pillName: {
          type: Sequelize.STRING(50),
          allowNull: false,
        },
        pillImage: {
            type: Sequelize.STRING(255),
        },
        pillDescription: {
          type: Sequelize.TEXT,
          allowNull: false,
        }, 
        pillType: {
          type: Sequelize.STRING(50),
          allowNull: false,
        },
        storageMethod: {
          type: Sequelize.STRING(100),
          allowNull: false,
        },
        medicineEffect: {
          type: Sequelize.TEXT,
          allowNull: false,
        },
      },
      {
        sequelize,
        timestamps: true,
        paranoid: true,
        modelName: 'Pill',
        tableName: 'pill',
        indexes: [
          {
            fields: ['pillName']
          },
          {
            fields: ['pillType']
          },
        ]
      },
    );
  }
  static associate(db) {
  db.Pill.belongsToMany(db.Prescription, { through: db.Instruction, foreignKey: 'pillID', sourceKey: 'pillID' });
  db.Pill.hasMany(db.Instruction, { foreignKey: 'pillID', sourceKey: 'pillID' });
  }
}

module.exports = Pill;