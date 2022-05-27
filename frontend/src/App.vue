<template>
  <head>
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css"
      integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g=="
      crossorigin="anonymous"
      referrerpolicy="no-referrer"
    />
  </head>
  <header>
    <div class="navigation">
      <nav
        class="
          navbar navbar-expand-sm navbar-light
          white
          nav
          d-flex
          justify-content-center
          flex-nav
          h
        "
        id="nav_bar"
      >
        <router-link id="logo" to="/home">
          <i class="fa-solid fa-globe"></i>
          <p>Groupomania</p>
        </router-link>
        <ul id="ul">
          <li class="nav-item" v-if="user">
            <a class="nav-link">
              <router-link
                id="nav_link"
                :to="{ name: 'user', params: { userId: user.id } }"
              >
                <i class="fa-solid fa-user userPageLink"></i>
              </router-link>
            </a>
          </li>
          <li class="nav-item" v-if="user">
            <a class="nav-link">
              <router-link id="nav_link" to="/settings">
                <i class="fa-solid fa-user-gear setting"></i>
              </router-link>
            </a>
          </li>
          <li class="nav-item" v-if="user">
            <a class="nav-link">
              <router-link id="nav_link" to="/">
                <i
                  @click="deconnexion"
                  class="fa-solid fa-arrow-right-from-bracket logout"
                ></i
              ></router-link>
            </a>
          </li>
        </ul>
        <form class="form-inline my-2 my-lg-0" v-if="user">
          <div class="flex_input">
            <input
              class="form-control mr-sm-2 inputsearch"
              id="inputsearch"
              type="search"
              placeholder="   Chercher un utilisateur"
              aria-label="Search"
              @keyup="search"
              @click="stopSearch"
              @blur="stopSearch"
            />
          </div>
          <div class="results" v-if="userSearch && research != ''">
            <div v-for="result in userSearch" :key="result.id" class="result">
              <router-link
                :to="{ name: 'user', params: { userId: result.id } }"
              >
                <img
                  class="imgSearch"
                  v-bind:src="result.pp"
                  alt=""
                  srcset=""
                />
                <span class="nameSearch"
                  >{{ result.prenom }} {{ result.nom }}</span
                >
              </router-link>
            </div>
          </div>
        </form>
      </nav>
    </div>
  </header>
  <router-view :key="$route.fullPath" />
</template>

<style lang="scss">
* {
  font-family: Monospace;
  // font-size: rem;
}
#logo {
  color: #fe2b01a6;
  height: 3.6rem;
  width: 18rem;
  font-size: 2rem;
  font-weight: bold;
  text-decoration: none;
  display: flex;
  justify-content: space-evenly;
  align-items: center;
  i,
  p {
    margin: 0;
  }
}
#ul {
  display: flex;
  justify-content: center;
  align-items: center;
  margin-right: 1rem;
  flex-wrap: wrap;
  padding-left: 0;
  margin-bottom: 0;
  list-style: none;
}

li {
  margin: 0;
  padding: 0;
  a {
    padding: 0;
  }
}
#nav_link {
  i {
    margin: 0;
    padding: 0;
    // border: 1px solid black;
    display: flex;
    justify-content: center;
    align-items: center;
    border-radius: 50%;
    font-size: 2rem;
    height: 3.3rem;
    width: 3.3rem;
    box-shadow: rgba(50, 50, 93, 0.25) 0px 2px 5px -1px;
    color: #fe2b01a6;
    &:hover {
      color: white;
      background-color: #fe2b01a6;
    }
  }
}
a:link {
  text-decoration: none;
}

.userPageLink {
  box-shadow: rgba(99, 99, 99, 0.2) 0px 2px 8px 0px;
}

#inputsearch {
  height: 3rem;
  width: 14rem;
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
  font-size: 1rem;
  &:focus {
    border: 1px solid #fe2b01a6;
  }
}
#text {
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
  font-size: 1.3rem;
  &:focus {
    border: 1px solid #fe2b01a6;
  }
}
.nameSearch {
  text-decoration: none;
  color: #091f43;
}
.imgSearch {
  object-fit: cover;
  height: 45px;
  width: 45px;
  margin: 10px;
  border-radius: 100%;
}
.results {
  position: absolute;
}
.result {
  width: 221px;
  border: 1px solid #fe2b01a6;
  background-color: white;
  width: 182px;
  &:hover {
    background-color: #fe2b01a6;
  }
}
a:hover {
  transition: 0.3s;
  transform: scale(1.1);
}
.userPageLink {
  object-fit: cover;
  height: 40px;
  width: 40px;
  margin-top: 0px;
  margin-bottom: 0px;
  margin-right: 40px;
  border-radius: 100%;
}
.homeLinkLil {
  height: 53px;
  margin-right: 20px;
}
.setting {
  height: 32px;
  margin-left: 20px;
}
.logout {
  height: 30px;
  width: 80px;
}
.navbar {
  border-bottom: 1px solid #dbdbdb;
  height: 55px;
}
.white {
  background-color: #fff;
}
body {
  margin: 0;
  background-color: #fafafa;
}
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  color: #2c3e50;
}
* {
  box-sizing: border-box;
}
#nav {
  background-color: #091f43;
  &_groupomania {
    width: 200px;
  }
  a {
    font-weight: bold;
    color: #2c3e50;
    &.router-link-exact-active {
      color: #d1515a;
    }
  }
}

@media only screen and (max-width: 768px) {
  .navbar {
    height: 14rem;
    display: flex;
    flex-direction: column;
  }
  .react {
    i {
      font-size: 1rem;
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
      research: "",
      userSearch: null,
      user: null,
      token: document.cookie
        ? document.cookie
            .split("; ")
            .find((row) => row.startsWith("user-token="))
            .split("=")[1]
        : null,
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
    appRecherche() {
      document.querySelector(".inputsearch").style.display = "block";
      document.querySelector(".cross").style.display = "block";
    },
    dispRecherche() {
      document.querySelector(".inputsearch").style.display = "none";
      document.querySelector(".cross").style.display = "none";
    },
    stopSearch() {
      const self = this;
      setTimeout(function () {
        self.research = null;
        self.userSearch = null;
      }, 100);
    },
    search(event) {
      this.research = event.target.value;
      const self = this;
      axios
        .post(
          "http://localhost:3000/api/user/getAs",
          { nom: self.research },
          {
            headers: {
              Authorization: `Bearer ${self.token}`,
            },
          }
        )
        .then((response) => {
          self.userSearch = response.data;
        })
        .catch(function (error) {
          if (error.response && error.response.status === 403) {
            self.$router.push("/");
          }
        });
    },
    deconnexion() {
      document.cookie = "userId=";
      document.cookie = "user-token=";
      this.$router.go();
    },
    getCurrentUser() {
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
        .then((response) => (self.user = response.data[0]))
        .catch(function (error) {
          if (error.response && error.response.status === 400) {
            document.cookie = "userId=";
            document.cookie = "user-token=";
            self.$router.push("/");
          }
        });
    },
  },
  mounted() {
    this.getCurrentUser();
    this.stopSearch();
  },
};
</script>