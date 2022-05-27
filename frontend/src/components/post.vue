<template>
  <router-view>
    <div class="d-flex justify-content-center newPost">
      <div
        class="
          home
          col-xs-12 col-md-10 col-lg-6
          d-flex
          flex-row
          justify-content-center
          align-items-center
          p-2
          bg-white
          mt-5 mt-2
          mb-2
          col-sm-12 col-md-10 col-lg-6
        "
        id="border"
      >
        <div class="form">
          <form v-on:submit.prevent>
            <div
              class="
                form-group
                mb-3
                col-12
                d-flex
                justify-content-center
                align-items-center
              "
            >
              <img v-if="user" v-bind:src="user.pp" alt="pp" class="ppPost" />
              <input
                type="text"
                class="form-control mb-2"
                id="text"
                aria-describedby="emailHelp"
                placeholder=" Quoi de neuf ?"
              />
            </div>
            <div class="d-flex justify-content-between">
              <label for="image" id="omage"
                ><i class="fa-solid fa-file-circle-plus"></i> Choisir un fichier
                :</label
              >
              <input
                @change="upload2"
                type="file"
                id="image"
                name="image"
                accept="image/png, image/jpeg"
              />
              <button
                @click="addPost()"
                id="publier"
                class="publier btn btn-primary"
              >
                Publier
              </button>
            </div>
          </form>
        </div>
      </div>
    </div>
    <div v-if="first">
      <div
        v-for="post in posts"
        :key="post.postId"
        class="d-flex justify-content-center"
      >
        <div
          class="bg-white mt-2 mb-2 col-sm-12 col-md-10 col-lg-6 posts"
          id="border"
        >
          <div>
            <div
              class="
                d-flex
                flex-row
                justify-content-between
                align-items-center
                p-2
                border-bottom
                infopost
              "
            >
              <div class="d-flex flex-row align-items-center px-2">
                <router-link
                  :to="{ name: 'user', params: { userId: post.authorId } }"
                >
                  <img
                    class="rounded-circle pp"
                    v-bind:src="post.pp"
                    width="45"
                  />
                </router-link>

                <div class="d-flex flex-column flex-wrap ml-2">
                  <span id="name" class="font-weight-bold nomUser"
                    >{{ post.prenom }} {{ post.nom }}</span
                  ><span class="text-black-50"
                    >Crée le {{ formatDate(post.date) }}</span
                  >
                </div>
                <div class="options">
                  <i
                    class="fa-solid fa-trash-can deletePost"
                    v-if="post.authorId == userId || (user && user.admin)"
                    @click="deletePost(post.postId, post.authorId)"
                  >
                  </i>
                </div>
              </div>
            </div>
          </div>
          <div v-if="post.text != ' '">
            <span id="ttext" class="text">{{ post.text }}</span>
          </div>
          <div v-if="post.imageUrl" class="mb-2" id="mb-2">
            <img
              class="img-fluid img-responsive imagePost"
              v-bind:src="post.imageUrl"
            />
          </div>
          <div class="react border-bottom">
            <div class="like" @click="liked">
              <i
                class="fa-solid fa-heart xert"
                @click="like(post.postId)"
                v-if="likedPost.includes(post.postId)"
              ></i>
              <i
                class="fa-regular fa-heart"
                @click="like(post.postId)"
                v-else
              ></i>
              <span class="nbr">{{ post.like }}</span>
            </div>
            <div class="comment">
              <i class="fa-solid fa-comment xomment" @click="afficherComment"></i>
              <span class="nbr nbre">{{ post.comment }}</span>
            </div>
          </div>
          <div class="block-com">
            <div
              class="comments"
              v-for="comment in comments"
              :key="comment.idComment"
            >
              <div class="pp" v-if="post.postId === comment.postId">
                <router-link
                  :to="{ name: 'user', params: { userId: comment.authorId } }"
                >
                  <img
                    class="rounded-circle pp2"
                    v-bind:src="comment.pp"
                    alt="pp comment"
                    srcset=""
                  />
                </router-link>
              </div>
              <div v-if="post.postId === comment.postId" class="commentaire">
                <span class="commentAuthor"
                  >{{ comment.prenom }} {{ comment.nom }}</span
                >
                <p class="commentText">{{ comment.comment }}</p>
                <i
                  class="fa-solid fa-trash-can delete"
                  v-if="comment.id == userId || (user && user.admin)"
                  @click="
                    deleteComment(
                      comment.idComment,
                      comment.authorId,
                      post.postId
                    )
                  "
                ></i>
              </div>
            </div>
          </div>
          <div class="col-10 d-flex justify-content-center comment">
            <input
              v-on:keyup.enter="comment($event, post.postId)"
              @change="upload"
              type="text"
              class="form-control mt-3 mb-3"
              id="comment"
              aria-describedby="comment"
              placeholder="Ajoutez un commentaire ..."
            />
          </div>
        </div>
      </div>
    </div>
    <div v-else class="noPost">
      <p id="no_text" class="text-noPost">Aucun post ici pour le moment ...</p>
    </div>
  </router-view>
</template>
<style lang="scss" scoped>
#publier {
  color: #fe2b01a6;
  background-color: white;
  border: 1px solid #fe2b01a6;
  &:hover {
    color: white;
    background-color: #fe2b01a6;
  }
}
#image {
  display: none;
}
#omage {
  color: white;
  background-color: #fe2b01a6;
  padding: 0.5rem 1rem;
  border-radius: 0.4rem;
  border: none;
  box-shadow: rgba(99, 99, 99, 0.2) 0px 2px 8px 0px;
  cursor: pointer;
  transition: 0.3s;
  width: max-content;
}
#name {
  font-weight: bold;
  color: #fe2b01a6;
}
.text-noPost {
  text-align: center;
  font-weight: 500;
  font-style: italic;
  font-size: 20px;
  color: #091f43;
}
.noPost {
  width: 500px;
  margin: auto;
  margin-top: 100px;
}
.infopost {
  position: relative;
}
.text {
  display: flex;
  justify-content: center;
  align-items: center;
  padding-top: 15px;
  padding-bottom: 10px;
  width: 95%;
  margin-left: auto;
  margin-right: auto;
  color: #091f43;
}
.imagePost {
  object-fit: cover;
  max-height: max-content;
  width: 100%;
  margin: 0px;
  padding: 0px;
}

#mb-2 {
  height: max-content;
  img {
    height: max-content;
  }
}
.react {
  display: flex;
  justify-content: center;
  align-items: center;
  margin-bottom: 15px;
  padding-bottom: 5px;
  i {
    font-size: 1.7rem;
    animation: heart 0.5s cubic-bezier(0.06, 1.16, 0.83, 0.67) forwards;
  }
  .xert {
    color: #fe2b01a6;
  }
}
.like,
.comment {
  display: flex;
  justify-content: center;
  align-items: center;
  margin: auto;
  cursor: pointer;
}
.heart {
  animation: heart 0.3s cubic-bezier(0.06, 1.16, 0.83, 0.67);
}
@keyframes heart {
  0% {
    transform: scale(1);
  }
  100% {
    transform: scale(1.2);
  }
}
.ppPost {
  height: 45px;
  width: 45px;
  margin-right: 10px;
  border-radius: 100%;
  object-fit: cover;
}
.publier {
  width: 100px;
}
.home {
  height: 140px;
}
.form {
  width: 90%;
}
#text {
  border-radius: 20px;
  background-color: #f0f2f5;
  color: #091f43;
  font-size: 1.2rem;
}
.nbr {
  font-weight: 300;
  font-size: 20px;
  margin-left: 10px;
  margin-right: 10px;
}
.posts:hover {
  .deletePost {
    display: inline;
  }
}
.posts {
  overflow: hidden;
}
.deletePost {
  position: absolute;
  right: 20px;
  display: none;
  cursor: pointer;
  font-size: large;
  transition: 300ms;
  &:hover {
    color: #fe2b01a6;
  }
}
.menu {
  width: 5rem;
  height: 3rem;
  display: flex;
  justify-content: space-evenly;
  align-items: center;
  font-size: 1.5rem;
  position: absolute;
  right: -5rem;
  top: 1.8rem;
  transition-delay: 2s;
  transition-timing-function: cubic-bezier(0.19, 1, 0.22, 1);
  transition-duration: 0.4s;
  i {
    transition: 0.3s;
    &:hover {
      color: #fe2b01a6;
      cursor: pointer;
    }
  }
}
.delete {
  height: 15px;
  position: absolute;
  top: 5px;
  right: 10px;
  display: none;
  cursor: pointer;
  margin-left: 20px;
  transition: 0.3s;
  &:hover {
    color: #fe2b01a6;
  }
}
.commentText {
  margin-left: 10px;
  margin-right: 10px;
  color: #091f43;
  font-size: 1.2rem;
}
.commentAuthor {
  font-weight: bold;
  margin-left: 10px;
  margin-right: 10px;
  padding-top: 10px;
  color: #fe2b01a6;
}
.comment {
  margin: auto;
}
#comment {
  height: 3rem;
  text-align-last: center;
  display: flex;
  justify-content: center;
  align-items: center;
  padding: 0;
  background-color: #f0f2f5;
  text-align: center;
  border-radius: 1rem;
  border: none;
  box-sizing: border-box;
  outline: none;
  transition: 0.6s;
  box-shadow: rgba(99, 99, 99, 0.2) 0px 2px 8px 0px;
  text-align: center;
  color: black;
  font-size: 1.2rem;
  &:focus {
    border: 1px solid #fe2b01a6;
  }
}
#border {
  border: 1px solid #fe2b01a6;
}
@media screen and (max-width: 768px) {
  #border {
    width: 581px;
  }
}
.nomUser {
  font-weight: bold;
  font-size: 19px;
  color: #091f43;
}
.pp {
  object-fit: cover;
  margin-right: 18px;
  height: 55px;
  width: 55px;
}
.pp2 {
  object-fit: cover;
  height: 40px;
  width: 40px;
  margin-left: 20px;
}
.comments {
  display: flex;
}
#ttext{
  font-size: x-large;
}
.disp {
  display: none;
}
.time {
  font-size: 9px !important;
}
.socials i {
  margin-right: 14px;
  font-size: 17px;
  color: #d2c8c8;
  cursor: pointer;
}
.feed-image img {
  width: 100%;
  height: auto;
}
#comment {
  border-radius: 20px;
  background-color: #f0f2f5;
}
.commentaire {
  background-color: #f0f2f5;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: flex-start;
  border-radius: 2rem 0 2rem;
  height: 3rem;
  padding: 0 1.5rem 0 0;
  margin-bottom: 1rem;
  position: relative;
  transition: 0.3s;
  box-shadow: rgba(99, 99, 99, 0.2) 0px 2px 8px 0px;
  &:hover {
    .delete {
      display: block;
    }
  }
}
</style>

<script>
import axios from "axios";
const CryptoJS = require("crypto-js");

export default {
  data() {
    return {
      first: null,
      user: null,
      likedPost: [],
      posts: null,
      postsRecive: null,
      token: document.cookie
        ? document.cookie
            .split("; ")
            .find((row) => row.startsWith("user-token="))
            .split("=")[1]
        : null,
      comments: null,
      newComment: null,
      userId: document.cookie
        ? CryptoJS.AES.decrypt(
            document.cookie
              .split("; ")
              .find((row) => row.startsWith("userId="))
              .split("=")[1],
            this.$store.state.CryptoKey
          ).toString(CryptoJS.enc.Utf8)
        : null,
    };
  },
  methods: {
    formatDate(input) {
      var datePart = input.match(/\d+/g),
        year = datePart[0].substring(2), // get only two digits
        month = datePart[1],
        day = datePart[2];
      return day + "/" + month + "/" + year;
    },
    afficherComment(event) {
      let path;
      if (event.path[3].children[3].matches(".react")) {
        path = event.path[3].children[4];
      } else {
        path = event.path[3].children[3];
      }
      if (path.matches(".disp")) {
        path.classList.remove("disp");
      } else {
        path.classList.add("disp");
      }
    },
    upload2(event) {
      this.image = event.target.files[0];
    },
    addPost() {
      this.token = document.cookie
        .split("; ")
        .find((row) => row.startsWith("user-token="))
        .split("=")[1];
      this.text = document.querySelector("#text").value;
      const fd = new FormData();
      fd.append("userId", this.userId);
      if (this.text != "") {
        fd.append("text", this.text);
      }
      if (this.image) {
        fd.append("image", this.image, "image");
      }
      if (this.text || this.image) {
        const self = this;
        axios
          .post("http://localhost:3000/api/post", fd, {
            headers: {
              "Content-Type": "multipart/form-data",
              Authorization: `Bearer ${this.token}`,
            },
          })
          .then(function (response) {
            console.log(response);
            document.querySelector("#text").value = null;
            self.getPost();
          })
          .catch(function (error) {
            console.log(error);
          });
      }
    },
    liked() {
      const self = this;
      axios
        .post("http://localhost:3000/api/like/liked", {
          userId: this.userId,
        })
        .then(function (response) {
          const ObjlikedPosts = response.data;
          self.likedPost = [];
          for (const ObjlikedPost of ObjlikedPosts) {
            self.likedPost.push(ObjlikedPost.postId);
          }
        })
        .catch(function (error) {
          console.log(error);
        });
    },
    deletePost(postId, authorId) {
      const self = this;
      if (this.userId == authorId || (self.user && self.user.admin)) {
        axios
          .delete(`http://localhost:3000/api/post/${postId}`, {
            headers: { Authorization: `Bearer ${this.token}` },
            data: { userId: self.userId, admin: self.user.admin },
          })
          .then((response) => {
            console.log(response);
            self.getPost();
          })
          .catch(function (error) {
            console.log(error);
          });
      }
    },
    like(currentPostId) {
      const self = this;
      axios
        .post("http://localhost:3000/api/like", {
          userId: this.userId,
          postId: currentPostId,
        })
        .then(function (response) {
          console.log(response);
          self.liked();
          self.getPost();
        })
        .catch(function (error) {
          console.log(error);
        });
    },
    deleteComment(id, authorId, currentPostId) {
      const self = this;
      if (this.userId == authorId || (self.user && self.user.admin)) {
        axios
          .delete(`http://localhost:3000/api/comment/${id}/${currentPostId}`, {
            headers: { Authorization: `Bearer ${this.token}` },
            data: { userId: self.userId, admin: self.user.admin },
          })
          .then((response) => {
            console.log(response);
            self.getPost();
          })
          .catch(function (error) {
            console.log(error);
          });
      }
    },
    upload(event) {
      this.newComment = event.target.value;
    },
    comment(event, id) {
      if (this.newComment) {
        const self = this;
        axios
          .post(
            "http://localhost:3000/api/comment",
            {
              comment: this.newComment,
              authorId: this.userId,
              postId: id,
            },
            {
              headers: { Authorization: `Bearer ${this.token}` },
            }
          )
          .then(function (response) {
            console.log(response);
            let pathClass, pathInput;
            if (event.path[2].children[3].matches(".react")) {
              pathClass = event.path[2].children[4];
              pathInput = event.path[2].children[5].children[0];
            } else {
              pathClass = event.path[2].children[3];
              pathInput = event.path[2].children[4].children[0];
            }
            pathClass.classList.remove("disp");
            pathInput.value = null;
            self.getPost();
          })
          .catch(function (error) {
            console.log(error);
          });
      }
    },
    getPost() {
      if (document.cookie) {
        this.token = document.cookie
          .split("; ")
          .find((row) => row.startsWith("user-token="))
          .split("=")[1];
      }
      const self = this;
      axios
        .get("http://localhost:3000/api/post", {
          headers: { Authorization: `Bearer ${this.token}` },
        })
        .then((response) => {
          this.postsRecive = response.data;
          this.first = this.postsRecive[0];
          if (this.posts != this.postsRecive) {
            this.posts = this.postsRecive;
          }
        })
        .catch(function (error) {
          if (error.response && error.response.status === 401) {
            self.$router.push("/");
          }
        });
      axios
        .get("http://localhost:3000/api/comment", {
          headers: { Authorization: `Bearer ${this.token}` },
        })
        .then((response) => (this.comments = response.data))
        .catch(function (error) {
          if (error.response && error.response.status === 401) {
            self.$router.push("/");
          }
        });
    },
  },
  mounted() {
    (this.userId = document.cookie
      ? CryptoJS.AES.decrypt(
          document.cookie
            .split("; ")
            .find((row) => row.startsWith("userId="))
            .split("=")[1],
          this.$store.state.CryptoKey
        ).toString(CryptoJS.enc.Utf8)
      : null),
      (this.token = document.cookie
        ? document.cookie
            .split("; ")
            .find((row) => row.startsWith("user-token="))
            .split("=")[1]
        : null);
    const self = this;
    axios
      .post(
        "http://localhost:3000/api/user",
        { userId: self.userId },
        {
          headers: {
            Authorization: `Bearer ${self.token}`,
          },
        }
      )
      .then((response) => {
        self.user = response.data[0];
      })
      .catch(function (error) {
        if (error.response && error.response.status === 400) {
          document.cookie = "userId=";
          document.cookie = "user-token=";
          self.$router.push("/");
        }
      });

    this.getPost();
    this.liked();
    if (!this.userId) {
      this.$router.push("/");
    }
  },
};
</script>
