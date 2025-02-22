import mongoose from "mongoose";

const ImageSchema = new mongoose.Schema({
  uid: { type: String, required: true, unique: true },
  folder_id: { type: mongoose.Schema.Types.ObjectId, ref: "Folder", required: true },
  reviews_left: { type: Number, required: true },
  reviews: [
    [
      { x: Number, y: Number },
      { x: Number, y: Number },
      { x: Number, y: Number },
      { x: Number, y: Number },
    ],
  ],
});

export default mongoose.models.Image || mongoose.model("Image", ImageSchema);
