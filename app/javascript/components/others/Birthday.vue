<template>
  <div>
    <v-row
      v-if="length !== 0"
      class="bg-brown-400 pA-3"
      justify="center"
      align-content="center"
    >
      <v-col
        cols="12"
        sm="12"
      >
        <div class="text-xl top-sub-title mb-5 lg:text-4xl lg:mb-10">
          <v-icon
            large
            color="white"
          >
            mdi-cake-variant
          </v-icon>
          今月誕生日の社員さん
          <v-icon
            large
            color="white"
          >
            mdi-cake-variant
          </v-icon>
        </div>
      </v-col>
      <v-col
        cols="12"
        sm="10"
      >
        <div
          class="text-2xl lg:text-4xl text-white border-dashed border-t-8 border-b-8 border-white pb-2 inline-block"
        >
          HAPPY BIRTHDAY!!
        </div>
      </v-col>
      <v-col
        v-for="birthdayUserProfile in birthdayUserProfiles"
        :key="birthdayUserProfile.public_uid"
        cols="12"
        sm="12"
        lg="4"
      >
        <div class="border-2 border-dotted border-white pa-5">
          <v-hover v-slot="{ hover }">
            <v-card
              class="mx-auto"
              :class="{ 'on-hover': hover }"
              max-width="344"
              outlined
              color="brown lighten-5"
              @click="moveToUserProfilePage(birthdayUserProfile)"
            >
              <v-img
                :src="birthdayUserProfile.user.image.url"
                max-height="250px"
              />

              <div class="text-center font-bold text-4xl pt-5 text-brown-600">
                {{ birthdayUserProfile.user.name }} さん
              </div>
              <v-card
                color="brown lighten-2"
                class="white--text"
              >
                誕生日 {{ birthdayUserProfile.birthday | moment }}
              </v-card>
            </v-card>
          </v-hover>
        </div>
      </v-col>
    </v-row>
  </div>
</template>

<script>
import axios from "axios";
import moment from "moment";

export default {
  filters: {
    moment: function (date) {
      return moment(date).format("MM月DD日");
    },
  },
  data() {
    return {
      birthdayUserProfiles: [],
    };
  },
  computed: {
    length() {
      return this.birthdayUserProfiles.length;
    },
  },
  mounted() {
    this.firstRead();
  },
  methods: {
    async firstRead() {
      await this.fetchBirthdayUserProfiles();
    },
    async fetchBirthdayUserProfiles() {
      await axios
        .get("/api/v1/profiles/birthday_user_profiles")
        .then((res) => (this.birthdayUserProfiles = res.data));
    },
    moveToUserProfilePage(profile) {
      this.$router.push(`/profiles/${profile.public_uid}`).catch((err) => {});
    },
  },
};
</script>

<style scoped>
.v-card {
  transition: transform 0.3s ease-in-out;
}

.v-card:not(.on-hover) {
  transform: scale(0.95);
}
</style>
