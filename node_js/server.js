import express from "express";
import mysql from "mysql2/promise";

let app = express();
let PORT = 3000;

app.use(express.json());
const pool = mysql.createPool({
    host: 'localhost',
    user: 'root',
    password: 'minhvu2001',
    database: 'fullstack',
    waitForConnections: true,
    connectionLimit: 10   
});

app.get("/api/users", async (req, res) => {
    try {
        const [rows] = await pool.query(
            'select * from Accounts'
        );
        res.status(200).json(rows);
    } catch (e) {
        res.status(500).json({status: 'error', message: e.message});
    }
});

app.post("/api/users", async (req, res) => {
    const {user_name, user_mail} = req.body;

    try {
        const [result] = await pool.query(
            'insert into Accounts (user_name, user_mail) values (?,?)', [user_name, user_mail]
        );
        res.status(201).json({
            status: 'success',
            message: 'User created successfully',
            data: {
                id: result.insertId,
                user_name,
                user_mail
            },
        });
    } catch (e) {
        res.status(500).json({status: 'error', message: e.message});
    }

});

app.put("/api/users/:id", async (req, res) => {
    const user_id = req.params.id;
    const {user_name, user_mail} = req.body;
    const conn = await pool.getConnection();
    try {
        await conn.beginTransaction();

        const [rows] = await conn.query(
            'select * from Accounts where user_id = ?',[user_id]
        );
        const user = rows[0];
        if(!user){
            throw new Error('User not found');
        }

        let fields = [];
        let values = [];

        if(user_name){
            fields.push("user_name = ?");
            values.push(user_name);
        }
        if(user_mail){
            fields.push('user_mail = ?');
            values.push(user_mail);
        }
        values.push(user_id);
        if(fields.length > 0) {
            await conn.query(
                `update Accounts set ${fields.join(", ")} where user_id = ?`, values
            );
        }

        await conn.commit();
        res.status(200).json({
            status: 'success',
            message: 'update user successfully',
            data: {
                user_id,
                user_name: user_name || user.user_name,
                user_mail: user_mail || user.user_mail
            }
        });
       
    } catch (e) {
        res.status(500).json({status: 'error', message: e.message});
    } finally {
        conn.release();
    }
});

app.delete("/api/users/:id", async (req, res) => {
    const user_id = req.params.id;
    try {
        await pool.query (
            'delete from Accounts where user_id = ?',[user_id]
        );
        res.status(200).json({
            status: "Success",
            message: "User deleted successfully",
            data: user_id
        });
    } catch (e) {
        res.status(500).json({status: 'error', message: e.message})
    }
});

app.listen(PORT,'0.0.0.0', () => console.log(`Server running at:http://localhost:${PORT}`));