<template>
  <div>
    <div
      v-if="shown"
      class="border-gray-500 rounded-xl border-2 mx-5 my-16 note"
    >
      <BasicAndProfCardBlock
        :is-this-edit-page="isThisEditPage"
        :user="user"
      />

      <FavoriteBlockList
        :is-this-edit-page="isThisEditPage"
        :user="user"
      />

      <QuestionBlockList
        :is-this-edit-page="isThisEditPage"
        :user="user"
      />

      <RankingBlockList
        :is-this-edit-page="isThisEditPage"
        :user="user"
      />

      <YesOrNoBlockList
        :is-this-edit-page="isThisEditPage"
        :user="user"
      />

      <TextBlockList
        :is-this-edit-page="isThisEditPage"
        :user="user"
      />
    </div>
    <ToTopButton />
  </div>
</template>

<script>
import axios from "axios";
import { mapState } from "vuex";

import BasicAndProfCardBlock from "../../components/basic_profile/BasicAndProfCardBlock";
import TextBlockList from "../../components/text_block/TextBlockList";
import QuestionBlockList from "../../components/question_block/QuestionBlockList";
import YesOrNoBlockList from "../../components/yes_or_no_block/YesOrNoBlockList";
import RankingBlockList from "../../components/ranking_block/RankingBlockList";
import FavoriteBlockList from "../../components/favorite_block/FavoriteBlockList";
import ToTopButton from "../../components/parts/ToTopButton";

export default {
  components: {
    BasicAndProfCardBlock,
    QuestionBlockList,
    YesOrNoBlockList,
    RankingBlockList,
    TextBlockList,
    FavoriteBlockList,
    ToTopButton,
  },
  props: {
    id: {
      type: String,
      require: true,
      default: "",
    },
  },
  data() {
    return {
      profile: {},
      user: {},
      shown: false,
    };
  },
  computed: {
    isThisEditPage() {
      return this.$route.path ==
        `/profiles/${this.user.profile.public_uid}/edit`
        ? true
        : false;
    },
  },
  created() {
    document.title = `プロフ編集 - プロフちゃん`;
  },
  mounted() {
    this.firstRead();
  },
  methods: {
    async firstRead() {
      await this.fetchProfile();
      await this.fetchUser();
      this.shown = true;
    },
    async fetchProfile() {
      await axios
        .get(`/api/v1/profiles/${this.id}`)
        .then((res) => (this.profile = res.data));
    },
    async fetchUser() {
      await axios
        .get(`/api/v1/users/${this.profile.user.id}`)
        .then((res) => (this.user = res.data));
    },
    moveToProfilesPage() {
      this.$router.push("/profiles").catch((err) => {});
    },
  },
};
</script>

<style>
.dot-color {
  color: #fff4dd;
  letter-spacing: 5rem;
}

.list-enter-active,
.list-leave-active,
.list-move {
  transition: 500ms cubic-bezier(0.59, 0.12, 0.34, 0.95);
  transition-property: opacity, transform;
}

.list-enter {
  opacity: 0;
  transform: translateX(50px) scaleY(0.5);
}

.list-enter-to {
  opacity: 1;
  transform: translateX(0) scaleY(1);
}

.list-leave-active {
  position: absolute;
}

.list-leave-to {
  opacity: 0;
  transform: scaleY(0);
  transform-origin: center top;
}

.note {
  background: linear-gradient(rgb(255, 245, 245) 5px, transparent 0.6px) #fffbf2;
  background-size: auto 5em;
  border-top: 1px solid #ccc;
  border-bottom: 1px solid #ccc;
  border-left: 1px solid #ccc;
  border-right: 1px solid #ccc;
  overflow: hidden;
}
</style>
