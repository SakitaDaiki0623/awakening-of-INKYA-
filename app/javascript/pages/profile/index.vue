<template>
  <div class="bg-backimage bg-cover bg-fixed">
    <v-container class="bg-brown-600 shadow-lg mb-16 mt-16">
      <p class="top-sub-title text-4xl text-center mb-16 pa-5">
        社員プロフ一覧
      </p>
      <v-row class="mb-10 pa-10">
        <v-col
          v-for="profile in displayProfiles"
          :key="profile.public_uid"
          cols="12"
          md="6"
          lg="4"
          class="border-white border-2 border-dotted"
        >
          <IndexProfCard :profile="profile" />
        </v-col>
      </v-row>
      <div class="text-center">
        <v-pagination
          v-model="page"
          :length="length"
          circle
          color="brown lighten-1"
          @input="pageChange"
          @next="moveToTop"
          @previous="moveToTop"
        />
      </div>
    </v-container>
  </div>
</template>

<script>
import axios from "axios";
import { mapState, mapActions } from "vuex";

import IndexProfCard from "../../components/basic_profile/IndexProfCard";

export default {
  components: {
    IndexProfCard,
  },
  data() {
    return {
      displayProfiles: [],
      profiles: [],
      pageSize: 9,
      page: 1,
      length: 0,
    };
  },
  mounted() {
    this.firstRead();
    document.title = "プロフ一覧 - プロフちゃん";
  },

  methods: {
    async firstRead() {
      await this.fetchProfiles();
      this.length = Math.ceil(this.profiles.length / this.pageSize);
      this.displayProfiles = this.profiles.slice(0, this.pageSize);
    },
    async fetchProfiles() {
      await axios
        .get("/api/v1/profiles")
        .then((response) => (this.profiles = response.data));
    },

    pageChange(pageNumber) {
      this.moveToTop();
      this.displayProfiles = this.profiles.slice(
        this.pageSize * (pageNumber - 1),
        this.pageSize * pageNumber
      );
    },
    moveToTop() {
      const duration = 10;
      const interval = 5;
      const step = -window.scrollY / Math.ceil(duration / interval);
      const timer = setInterval(() => {
        window.scrollBy(0, step);

        if (window.scrollY <= 0) {
          clearInterval(timer);
        }
      }, interval);
    },
  },
};
</script>
