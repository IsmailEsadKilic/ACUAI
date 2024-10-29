DEVELOPMENT NOTES

posts have has_many_attached :uploads
uploaded_files have_one_attached :upload
mind the singular/plural naming

admin can delete uploads or upload files

---

TODO
- [x] add a way to delete uploads
- [ ] internationalize the app
- [ ] add rich text editing to posts and comments (use ckeditor or trix)
- [ ] style _post
- [ ] style _comment
- [ ] style post/show
- [ ] style post/index
- [ ] style comment/_form
- [ ] style post/_form