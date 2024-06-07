const Sequelize = require('sequelize');
const Hooks = require('sequelize/lib/hooks');

class Instruction extends Sequelize.Model{
    static init (sequelize) {
    return super.init( 
    {
        pillID: {
            type: Sequelize.INTEGER,
            allowNull: false,
            primaryKey: true,
        },
        prescriptionID: {
            type: Sequelize.INTEGER,
            allowNull: false,
            primaryKey: true,
        },
        instruction: {
            type: Sequelize.TEXT,
        },
    },
    {
        sequelize,
        timestamps: true,
        paranoid: true,
        modelName: 'Instruction',
        tableName: 'instruction',
            },
        )
    }
    static associate(db) {
    db.Instruction.belongsTo(db.Pill, { foreignKey: 'pillID', targetKey: 'pillID' });
    db.Instruction.belongsTo(db.Prescription, { foreignKey: 'prescriptionID', targetKey: 'prescriptionID', onDelete: 'CASCADE', hooks: true});
    }
};


module.exports = Instruction;