const Sequelize = require('sequelize');

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
        userID: {
          type: Sequelize.STRING(50),
          allowNull: false,
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
      },
    );
  }

  static associate(db) {
    db.Pill.belongsTo(db.User, { foreignKey: 'userID', sourceKey: 'id' });
    db.Pill.belongsToMany(db.Prescription, { through: 'instruction', foreignKey: 'pillName', OtherKey: 'prescriptionID'});
  }
}

module.exports = Pill;