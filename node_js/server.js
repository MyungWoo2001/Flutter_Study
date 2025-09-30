import express from "express";

let app = express();
let PORT = 3000;

let users = [
    {id: 1, name: "Minh Vu", mail: "minhvu@gmail.com"}
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

app.post("/api/users", (req, res) => {
    const {name, mail} = req.body;
    const id = users.length + 1;
    const newUser = {id, name, mail};
    users.push(newUser);
    res.status(201).json(newUser);
});

app.put("/api/users/:id", (req, res) => {
    const user = users.find((u) => u.id === parseInt(req.params.id));
    if (!user) return res.status(404).json({message:"User not found!!!"});
    const {name, mail} = req.body;
    if(typeof name === "string") user.name = name;
    if(typeof mail === "string") user.mail = mail;
    res.status(200).json(user);
});

app.delete("/api/users/:id", async (req, res) => {
    const index = users.findIndex(s => s.id === parseInt(req.params.id));
    if(index === -1) return res.status(404).json({message: "User not found!"});
    const user = users.splice(index, 1);
    res.json({message: "User deleted!!!", data: user});
});

app.listen(PORT,'0.0.0.0', () => console.log(`Server running at:http://localhost:${PORT}`));