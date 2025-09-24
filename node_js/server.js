import express from "express";

let app = express();
let PORT = 3000;

let users = [
    {id: 1, name: "MyungWoo", age: 22},
    {id: 2, name: "MinhVu1", age: 24},
    {id: 3, name: "MinhVu2", age: 21},
    {id: 4, name: "MinhVu3", age: 20},
    {id: 5, name: "MinhVu4", age: 25},
    {id: 6, name: "MinhVu5", age: 23},
    {id: 7, name: "MinhVu6", age: 12},
    {id: 8, name: "MinhVu7", age: 18},
    {id: 9, name: "MinhVu8", age: 16},
    {id: 10, name: "MinhVu", age: 26},
];

function getRandomInt(max) {
    return Math.floor(Math.random() * max);
}

app.use(express.json());

app.get("/api/users", (req, res) => {
    res.json(users);
});

app.get("/api/delay", async (req, res) => {
    setTimeout(() => {
        res.json({message: "Data from server after 3s deday"});
    }, 3000);
});

app.get("/api/random", async (req, res) => {
    await new Promise(resolve => setTimeout(resolve, 200));
    const num = Math.floor(Math.random() * 101);
    res.json({number: num})
})

app.post("/api/users", (req, res) => {
    const {name, age} = req.body;
    const id = users.length + 1;
    const newUser = {id, name, age};
    users.push(newUser);
    res.status(201).json(newUser);
});

app.delete("/api/users/:id", async (req, res) => {
    const index = users.findIndex(s => s.id === parseInt(req.params.id));
    if(index === -1) return res.status(404).json({message: "User not found!"});
    const user = users.splice(index, 1);
    res.json({message: "User deleted!!!", data: user});
});

app.listen(PORT,'0.0.0.0', () => console.log(`Server running at:http://localhost:${PORT}`));