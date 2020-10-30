import express from "express";
import bodyParser from "body-parser";
import * as admin from "firebase-admin";
import { Note } from "./src/models/note";

const app = express();

admin.initializeApp({
  credential: admin.credential.applicationDefault(),
  databaseURL: "https://<DATABASE_NAME>.firebaseio.com",
});

const db = admin.firestore();

app.use(bodyParser.json());

app.get("/notes", async (req, res) => {
  const apiKey = req.headers.apikey?.toString();
  if (!apiKey) {
    res.status(401).send("");
    return;
  }

  const result = await db
    .collection("apiKeys")
    .doc(apiKey)
    .collection("notes")
    .get();

  res.send(
    result.docs.map((x) => {
      return { id: x.id, ...x.data() };
    })
  );
  res.status(200);
});

app.get("/notes:id", async (req, res) => {
  const apiKey = req.headers.apikey?.toString();
  if (!apiKey) {
    res.status(401).send("");
    return;
  }

  const result = await db
    .collection("apiKeys")
    .doc(apiKey)
    .collection("notes")
    .doc(req.params.id)
    .get();

  if (!result.exists) {
    res.status(404).send("");
    return;
  }

  res.send(result.data()).status(200);
});

app.post("/notes", async (req, res) => {
  const apiKey = req.headers.apikey?.toString();
  if (!apiKey) {
    res.status(401).send("");
    return;
  }

  if (!req.body) {
    res.status(400).send("");
    return;
  }

  const validations = [
    nullOrWhiteSpace(req.body.noteTitle),
    nullOrWhiteSpace(req.body.noteContent),
  ];

  if (validations.includes(true)) {
    res.status(400).send("");
    return;
  }

  const note: Note = {
    noteTitle: req.body.noteTitle,
    noteContent: req.body.noteContent,
    createDateTime: new Date().toUTCString(),
    latestEditDateTime: null,
  };

  const ref = db.collection("apiKeys").doc(apiKey).collection("notes").doc();

  await ref.set(note);

  res.send({ id: ref.id, ...note }).status(200);
});

app.put("/notes/:id", async (req, res) => {
  const apiKey = req.headers.apikey?.toString();
  if (!apiKey) {
    res.status(401).send("");
    return;
  }

  const ref = db
    .collection("apiKeys")
    .doc(apiKey)
    .collection("notes")
    .doc(req.params.id);

  const existingNote = await ref.get();
  if (!existingNote.exists) {
    res.status(404).send("");
    return;
  }

  const validations = [
    nullOrWhiteSpace(req.body.noteTitle),
    nullOrWhiteSpace(req.body.noteContent),
  ];

  if (validations.includes(true)) {
    res.status(400).send("");
    return;
  }

  const note: Partial<Note> = {
    noteTitle: req.body.noteTitle,
    noteContent: req.body.noteContent,
    latestEditDateTime: new Date().toUTCString(),
  };

  await ref.set(note, { merge: true });

  res.send("").status(204);
});

app.delete("/notes/:id", async (req, res) => {
  const apiKey = req.headers.apikey?.toString();
  if (!apiKey) {
    res.status(401).send("");
    return;
  }

  const ref = db
    .collection("apiKeys")
    .doc(apiKey)
    .collection("notes")
    .doc(req.params.id);

  const existingNote = await ref.get();
  if (!existingNote.exists) {
    res.status(404).send("");
    return;
  }

  await ref.delete();
  res.send("").status(204);
});

app.get("/apiKey", async (req, res) => {
  const apiKeyRef =  db.collection("apiKeys").doc();
  await apiKeyRef.create({});

  const notesRef = db.collection("apiKeys").doc(apiKeyRef.id).collection("notes");
  await Promise.all([
    notesRef.doc().create({
      noteTitle: 'Welcome',
      noteContent: 'This is a test note',
      createDateTime: new Date().toUTCString(),
      latestEditDateTime: null,
    }),
    notesRef.doc().create({
      noteTitle: 'Hello',
      noteContent: 'This is an another test note',
      createDateTime: new Date().toUTCString(),
      latestEditDateTime: null,
    }),
    notesRef.doc().create({
      noteTitle: 'And finally',
      noteContent: 'We have the third test note',
      createDateTime: new Date().toUTCString(),
      latestEditDateTime: null,
    })
  ]);

  res.status(200).send({
    apiKey: apiKeyRef.id
  });
});

function nullOrWhiteSpace(str: string) {
  return !str || str.trim().length === 0;
}

app.listen(process.env.PORT || 4000);
