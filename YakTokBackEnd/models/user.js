const Sequelize = require('sequelize');

class User extends Sequelize.Model {
  static init(sequelize) {
    return super.init(
      {
        id: {
          type: Sequelize.STRING(50),
          allowNull: false,
          primaryKey: true,
        },
        userName: {
          type: Sequelize.STRING(50),
          allowNull: false,
        },
        password: {
          type: Sequelize.STRING(200),
          allowNull: false,
        },
      },
      {
        sequelize,
        timestamps: true,
        paranoid: true,
        modelName: 'User',
        tableName: 'user',
      }
    );
  }

  static associate(db) {
    db.User.hasMany(db.Pill, { foreignKey: 'userID', sourceKey: 'id' });
    db.User.hasMany(db.Prescription, { foreignKey: 'userID', sourceKey: 'id' });
    db.User.hasMany(db.Receipt, { foreignKey: 'userID', sourceKey: 'id' });
  }
}

module.exports = User;
