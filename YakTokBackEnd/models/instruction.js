const { sequelize, Prescription } = require(".");
const { DataTypes } = require("sequelize");
const { Pill } = require("./index");

const Instruction = sequelize.define(
    'Instruction', 
    {
        pillID: {
            type: DataTypes.INTEGER,
            allowNull: false,
            primaryKey: true,
        },
        prescriptionID: {
            type: DataTypes.INTEGER,
            allowNull: false,
            primaryKey: true,
        },
        pillName: {
            type: DataTypes.STRING(50),
            allowNull: false,
            primaryKey: true,
        },
        instruction: {
            type: DataTypes.STRING(100),
        },
    },
    {
        timestamps: true,
        paranoid: true,
        modelName: 'Instruction',
        tableName: 'instruction',
    },
    
);
Pill.belongsToMany(Prescription, { through: Instruction, foreignKey: 'pillID', sourceKey: 'pillID' }),
Prescription.belongsToMany(Pill, { through: Instruction, foreignKey: 'prescriptionID', sourceKey: 'prescriptionID' }),

module.exports = Instruction;