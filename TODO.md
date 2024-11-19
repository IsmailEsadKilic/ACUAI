# DEVELOPMENT NOTES

posts have has_many_attached :uploads
uploaded_files have_one_attached :upload
mind the singular/plural naming

admin can delete uploads or upload files

---

TODO
- [ ] internationalize the app = 
- [ ] add rich text editing to posts and comments (use ckeditor or trix) = Arda
- [ ] unit testing = Arda
- [ ] e mailing
- [ ] e mail confirmation
- [ ] style _post
- [ ] style _comment
- [ ] style post/show
- [ ] style post/index
- [ ] style comment/_form
- [ ] style post/_form
- [ ] subscribtion to posts
- [ ] comment liking