const { Sequelize, Op } = require('sequelize');
const modelCharacter = require('./models/Character.js');
const modelAbility = require('./models/Ability.js');
const modelRole = require('./models/Role.js');
//Sequelize('postgres://Username:password@localhost:portDelPsql/nameDeLaDB)
const db = new Sequelize('postgres://postgres:321724AAa@localhost:5432/henry_sequelize', {
  logging: false,
});

modelCharacter(db);
modelAbility(db);
modelRole(db);

module.exports = {
  ...db.models,
  db,
  Op
}