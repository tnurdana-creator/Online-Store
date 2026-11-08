
const express = require('express');
const sql = require('msnodesqlv8');

const app = express();
app.use(express.json());

const connectionString =
    'Driver={ODBC Driver 17 for SQL Server};' +
    'Server=DESKTOP-O4F5G0A;' +
    'Database=Online_store_db;' +
    'Trusted_Connection=Yes;' +
    'TrustServerCertificate=Yes;';

// 1. Barlyq tauarlardy alu
app.get('/api/tauar', (req, res) => {
    sql.query(connectionString, 'SELECT * FROM tauar', (error, rows) => {
        if (error) {
            return res.status(500).json({ qate: error.message });
        }

        res.json(rows);
    });
});

// 2. ID boiynsha tauardy alu
app.get('/api/tauar/:id', (req, res) => {
    const id = Number(req.params.id);

    if (!Number.isInteger(id) || id <= 0) {
        return res.status(400).json({ qate: 'ID durys emes' });
    }

    const query = 'SELECT * FROM tauar WHERE id = ?';

    sql.query(connectionString, query, [id], (error, rows) => {
        if (error) {
            return res.status(500).json({ qate: error.message });
        }

        if (rows.length === 0) {
            return res.status(404).json({ qate: 'Tauar tabylmady' });
        }

        res.json(rows[0]);
    });
});

 // 3-suranys. Zhana tauar qosu (POST)
app.post('/api/tauar', (req, res) => {
    const { atauy, bagasy } = req.body;

    if (
        typeof atauy !== 'string' ||
        atauy.trim() === '' ||
        atauy.trim().length > 150 ||
        typeof bagasy !== 'number' ||
        !Number.isFinite(bagasy) ||
        bagasy < 0 ||
        bagasy > 99999999.99
    ) {
        return res.status(400).json({
            qate: 'Tauar atauy nemese bagasy durys emes'
        });
    }

    const query = `
        INSERT INTO tauar (atauy, bagasy)
        OUTPUT INSERTED.id, INSERTED.atauy, INSERTED.bagasy
        VALUES (?, ?)
    `;

    sql.query(connectionString, query, [atauy.trim(), bagasy], (error, rows) => {
        if (error) {
            return res.status(500).json({ qate: error.message });
        }

        res.status(201).json({
            habar: 'Zhana tauar qosyldy',
            tauar: rows[0]
        });
    });
});

 // 4-suranys. Tauar aqparatyn ozgertu (PUT)
app.put('/api/tauar/:id', (req, res) => {
    const id = Number(req.params.id);
    const { atauy, bagasy } = req.body;

    if (
        !Number.isInteger(id) ||
        id <= 0 ||
        typeof atauy !== 'string' ||
        atauy.trim() === '' ||
        atauy.trim().length > 150 ||
        typeof bagasy !== 'number' ||
        !Number.isFinite(bagasy) ||
        bagasy < 0 ||
        bagasy > 99999999.99
    ) {
        return res.status(400).json({
            qate: 'Engizilgen derekter durys emes'
        });
    }

    const query = `
        UPDATE tauar
        SET atauy = ?, bagasy = ?
        OUTPUT INSERTED.id, INSERTED.atauy, INSERTED.bagasy
        WHERE id = ?
    `;

    sql.query(connectionString, query, [atauy.trim(), bagasy, id], (error, rows) => {
        if (error) {
            return res.status(500).json({ qate: error.message });
        }

        if (rows.length === 0) {
            return res.status(404).json({
                qate: 'Tauar tabylmady'
            });
        }

        res.json({
            habar: 'Tauar aqparaty ozgertildi',
            tauar: rows[0]
        });
    });
});

// 5-suranys. Tauardy oshiru (DELETE)
app.delete('/api/tauar/:id', (req, res) => {
    const id = Number(req.params.id);

    if (!Number.isInteger(id) || id <= 0) {
        return res.status(400).json({
            qate: 'Tauar ID durys emes'
        });
    }

    const query = `
        DELETE FROM tauar
        OUTPUT DELETED.id
        WHERE id = ?
    `;

    sql.query(connectionString, query, [id], (error, rows) => {
        if (error) {
            return res.status(500).json({
                qate: error.message
            });
        }

        if (rows.length === 0) {
            return res.status(404).json({
                qate: 'Tauar tabylmady'
            });
        }

        res.json({
            habar: 'Tauar oshirildi',
            id: id
        });
    });
});

// Serverdi iske qosu
app.listen(3000, () => {
    console.log('REST API server iske qosылды!');
    console.log('http://localhost:3000/api/tauar');
});
