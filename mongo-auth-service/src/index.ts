import express from 'express'
import cors from 'cors'
import mongoose from 'mongoose'
import bcrypt from 'bcryptjs'

const MONGO_URI = process.env.MONGO_URI || 'mongodb://localhost:27017/simple_login'
const PORT = Number(process.env.PORT || 4000)

const app = express()
app.use(cors({ origin: '*'}))
app.use(express.json())

interface UserDoc extends mongoose.Document {
  username: string
  passwordHash: string
}

const userSchema = new mongoose.Schema<UserDoc>({
  username: { type: String, unique: true, required: true },
  passwordHash: { type: String, required: true },
})

const User = mongoose.model<UserDoc>('User', userSchema)

app.post('/api/login', async (req, res) => {
  const { username, password } = req.body || {}
  if (!username || !password) return res.status(400).json({ error: 'Missing fields' })
  const user = await User.findOne({ username }).exec()
  if (!user) return res.status(401).json({ error: 'Invalid credentials' })
  const ok = await bcrypt.compare(password, user.passwordHash)
  if (!ok) return res.status(401).json({ error: 'Invalid credentials' })
  // For demo, return the same token the backend expects
  return res.json({ token: 'fake-jwt-token' })
})

app.get('/api/health', (_req, res) => res.json({ ok: true }))

async function start() {
  await mongoose.connect(MONGO_URI)
  app.listen(PORT, () => console.log(`Mongo auth service listening on :${PORT}`))
}

start().catch((err) => {
  console.error(err)
  process.exit(1)
})
