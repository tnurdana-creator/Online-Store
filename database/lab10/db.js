const sql = require('msnodesqlv8');

const connectionString =
    'Driver={ODBC Driver 17 for SQL Server};' +
    'Server=DESKTOP-O4F5G0A;' +
    'Database=Online_store_db;' +
    'Trusted_Connection=Yes;' +
    'TrustServerCertificate=Yes;';

sql.open(connectionString, (error, connection) => {
    if (error) {
        console.log('Derekqorga qosylu qatesi:', error.message);
        return;
    }

    console.log('Online_store_db derekqoryna qosylu satti!');

    connection.query('SELECT * FROM tauar', (error, rows) => {
        if (error) {
            console.log('SQL suranys qatesi:', error.message);
        } else {
            console.log('Tauarlar tizimi:', rows);
        }

        connection.close();
    });
});
