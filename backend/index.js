const express = require('express');
const app = express();
const port = 8000;

const mysql = require('mysql2');

const connection = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '',
  database: 'livechat'
});

// Middleware to parse JSON bodies
app.use(express.json());

function underscore_to_space(string){
  return string.replace(/_/g, " ");
}

app.post('/', (req, res) => {
    var query = "SELECT * FROM chat ORDER BY idMsg";
    
    connection.query(query, (err, result) => {
        if(err) throw err;
        else{
            res.json(result);
        }
    });
});

app.post('/enviar', (req, res) => {
    // Extracting the message content from the request body
    var message = req.body;

    var nome = message.nome;
    var msg = message.content;
    console.log(nome);
    console.log(msg);
  
 
    // SQL query to insert the message into the database
    var query = "INSERT INTO chat (idMsg, nome, content) VALUES (NULL, ?, ?)";
  
    // Executing the SQL query with parameters
    connection.query(query, [nome, msg], (err, result) => {
      if (err) {
        console.error("Error inserting message:", err);
        res.status(500).json({ error: "Failed to insert message" });
      } else {
        console.log("Message inserted successfully:", result);
        res.status(200).json({ success: true });
      }
    });
});

app.post('/apagar', (req, res) => {
  var query = "DELETE FROM chat";
  connection.query(query, (err, result) => {
    if(err) throw err;
    else{
      res.send(result);
    }
  });
});

app.listen(port, () => {
  console.log(`Example app listening at http://localhost:${port}`)
});
