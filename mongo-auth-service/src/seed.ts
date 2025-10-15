import mongoose from 'mongoose'
import bcrypt from 'bcryptjs'

const MONGO_URI = process.env.MONGO_URI || 'mongodb://localhost:27017/simple_login'

interface UserDoc extends mongoose.Document {
  username: string
  passwordHash: string
}

const userSchema = new mongoose.Schema<UserDoc>({
  username: { type: String, unique: true, required: true },
  passwordHash: { type: String, required: true },
})

const User = mongoose.model<UserDoc>('User', userSchema)

async function seed() {
  await mongoose.connect(MONGO_URI)
  const hash = await bcrypt.hash('password', 10)
  await User.updateOne({ username: 'admin' }, { $set: { username: 'admin', passwordHash: hash } }, { upsert: true })
  console.log('Seeded user admin/password')
  await mongoose.disconnect()
}

seed().catch((e) => {
  console.error(e)
  process.exit(1)
})
