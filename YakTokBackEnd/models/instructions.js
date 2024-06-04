const Sequelize = require('sequelize');

class Instructions extends Sequelize.Model {
  static init(sequelize) {
    return super.init(
      { 
        userID: {
          type: Sequelize.STRING(50),
          allowNull: false,
        },
        pillName: {
          type: Sequelize.STRING(50),
          allowNull: false,
          unique: true,
        },
        instructionID: {
          type: Sequelize.INTEGER,
          primaryKey: true,
        },
        instruction: {
          type: Sequelize.TEXT,
          allowNull: false,
        },
      },
      {
        sequelize,
        timestamps: true,
        paranoid: true,
        modelName: 'Instructions',
        tableName: 'instructions',
      }
    );
  }

  static associate(db) {
    db.Instructions.belongsTo(db.Pill, { foreignKey: 'pillName', sourceKey: 'pillName' });
    db.Instructions.belongsTo(db.User, { foreignKey: 'id', sourceKey: 'userID' });
  }
}

module.exports = Instructions;