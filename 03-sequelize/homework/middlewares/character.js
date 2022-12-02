const { Router } = require('express');
const { Op, Character, Role } = require('../db');
const router = Router();

router.post('/', async (req, res)=>{
    try {
        const {code, name, age, race, hp, mana, date_added} = req.body;
        if(!code || !name || !hp || !mana){
            return res.status(404).send("Falta enviar datos obligatorios");
        }
        await Character.create({
            code, 
            name, 
            age, 
            race, 
            hp, 
            mana, 
            date_added
        })
        const newCharacter = Character.findByPk(code);
        res.status(201).send(newCharacter)
    } catch (error) {
        res.status(404).send("Error en alguno de los datos provistos")
    }
})

router.get('/', async (req, res)=>{
    try {
        const {race, name, hp, age} = req.query;
        let foundCharacter;
        if (race && age){
            foundCharacter = await Character.findAll({
                where: {
                    race,
                    age
                }
            })
            return res.send(foundCharacter)
        }
        if (name && hp){
            foundCharacter = await Character.findAll({
                where: {
                    name,
                    hp
                }
            })
            return res.send(foundCharacter)
        }
        if (race){
            foundCharacter = await Character.findAll({
                where: {
                    race
                }
            })
            return res.send(foundCharacter)
        }
        foundCharacter = await Character.findAll();
        return res.send(foundCharacter)
    } catch (error) {
        res.status(404).send(error)
    }
})

router.get('/:code', async (req, res)=>{
    try {
        const {code} = req.params;
        let foundCharacter = Character.findByPk(code);
        if(!foundCharacter) return res.status(404).send(`El código ${code} no corresponde a un personaje existente`);
        res.send(foundCharacter)
    } catch (error) {
        res.status(404).send(error)
    }
})

module.exports = router;