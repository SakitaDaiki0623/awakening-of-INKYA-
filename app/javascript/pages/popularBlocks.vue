<template>
  <div>
    <Loading v-show="loading" />
    <div
      v-show="!loading"
      class="top"
    >
      <div v-if="isThereAnyBlock">
        <div class="top-bg mb-16">
          <div>
            <v-row>
              <v-col
                cols="12"
                sm="12"
              >
                <div class="text-center text-2xl md:text-4xl">
                  - - - - 社内で人気のブロック- - - -
                </div>
              </v-col>
            </v-row>
          </div>
        </div>
        <!-- Favorite ブロック -->
        <div
          v-if="favoritePopularBlocks.length !== 0"
          class="pa-10 sm:px-16 bg-brown-400 mb-16"
        >
          <v-row>
            <v-col
              cols="12"
              sm="11"
            >
              <div
                class="text-center text-4xl text-white pa-5 border-class font-bold"
              >
                Favorite ブロック
              </div>
            </v-col>
            <v-col
              cols="12"
              sm="1"
              class="sm:mb-16"
            >
              <img
                src="../images/prof_normal.png"
                class="image mx-auto"
              >
            </v-col>
            <v-col
              v-for="favoriteBlock in favoritePopularBlocks"
              :key="favoriteBlock.id"
              cols="12"
              md="4"
              class="border-2 border-white border-dashed"
            >
              <div class="bg-white pa-1 inline-block">
                {{ favoriteBlock.owing_user_name }}
              </div>
              <v-img
                max-width="50px"
                :src="favoriteBlock.owing_user_image.url"
                class="inline"
              />
              <FavoriteBlockCard :favorite-block="favoriteBlock" />
            </v-col>
          </v-row>
        </div>
        <!-- /Favorite ブロック -->

        <!-- クエスチョンブロック -->
        <div
          v-if="questionPopularBlocks.length !== 0"
          class="pa-10 sm:px-16 bg-brown-300 mb-16"
        >
          <v-row>
            <v-col
              cols="12"
              sm="11"
            >
              <div
                class="text-center text-4xl text-white pa-5 border-class font-bold"
              >
                クエスチョンブロック
              </div>
            </v-col>
            <v-col
              cols="12"
              sm="1"
              class="sm:mb-16"
            >
              <img
                src="../images/prof_happy.png"
                class="image mx-auto"
              >
            </v-col>
            <v-col
              v-for="questionBlock in questionPopularBlocks"
              :key="questionBlock.id"
              cols="12"
              md="6"
              lg="4"
              class="border-2 border-white border-dashed"
            >
              <div class="bg-white pa-1 inline-block">
                {{ questionBlock.owing_user_name }}
              </div>
              <v-img
                max-width="50px"
                :src="questionBlock.owing_user_image.url"
                class="inline"
              />
              <QuestionBlockCard :question-block="questionBlock" />
            </v-col>
          </v-row>
        </div>
        <!-- /クエスチョンブロック -->

        <!-- ランキングブロック -->
        <div
          v-if="rankingPopularBlocks.length !== 0"
          class="pa-10 sm:px-16 bg-brown-400 mb-16"
        >
          <v-row>
            <v-col
              cols="12"
              sm="11"
            >
              <div
                class="text-center text-4xl text-white pa-5 border-class font-bold"
              >
                ランキングブロック
              </div>
            </v-col>
            <v-col
              cols="12"
              sm="1"
              class="sm:mb-16"
            >
              <img
                src="../images/prof_open_normal.png"
                class="image mx-auto"
              >
            </v-col>
            <v-col
              v-for="rankingBlock in rankingPopularBlocks"
              :key="rankingBlock.id"
              cols="12"
              md="6"
              lg="4"
              class="border-2 border-white border-dashed"
            >
              <div class="bg-white pa-1 inline-block">
                {{ rankingBlock.owing_user_name }}
              </div>
              <v-img
                max-width="50px"
                :src="rankingBlock.owing_user_image.url"
                class="inline"
              />
              <RankingBlockCard :ranking-block="rankingBlock" />
            </v-col>
          </v-row>
        </div>
        <!-- /ランキングブロック -->

        <!-- Yes or No ブロック -->
        <div
          v-if="yesOrNoPopularBlocks.length !== 0"
          class="pa-10 sm:px-16 bg-brown-300 mb-16"
        >
          <v-row>
            <v-col
              cols="12"
              sm="11"
            >
              <div
                class="text-center text-4xl text-white pa-5 border-class font-bold"
              >
                Yes or No ブロック
              </div>
            </v-col>
            <v-col
              cols="12"
              sm="1"
              class="sm:mb-16"
            >
              <img
                src="../images/prof_open_happy.png"
                class="image mx-auto"
              >
            </v-col>
            <v-col
              v-for="yesOrNoBlock in yesOrNoPopularBlocks"
              :key="yesOrNoBlock.id"
              cols="12"
              md="6"
              lg="4"
              class="border-2 border-white border-dashed"
            >
              <div class="bg-white pa-1 inline-block">
                {{ yesOrNoBlock.owing_user_name }}
              </div>
              <v-img
                max-width="50px"
                :src="yesOrNoBlock.owing_user_image.url"
                class="inline"
              />
              <YesOrNoBlockCard :yes-or-no-block="yesOrNoBlock" />
            </v-col>
          </v-row>
        </div>
        <!-- /Yes or No ブロック -->

        <!-- テキストブロック -->
        <div
          v-if="textPopularBlocks.length !== 0"
          class="pa-10 sm:px-16 bg-brown-400 mb-16"
        >
          <v-row>
            <v-col
              cols="12"
              sm="11"
            >
              <div
                class="text-center text-4xl text-white pa-5 border-class font-bold"
              >
                テキストブロック
              </div>
            </v-col>
            <v-col
              cols="12"
              sm="1"
              class="sm:mb-16"
            >
              <img
                src="../images/prof_normal.png"
                class="image mx-auto"
              >
            </v-col>
            <v-col
              v-for="textBlock in textPopularBlocks"
              :key="textBlock.id"
              cols="12"
              md="6"
              lg="4"
              class="border-2 border-white border-dashed"
            >
              <div class="bg-white pa-1 inline-block">
                {{ textBlock.owing_user_name }}
              </div>
              <v-img
                max-width="50px"
                :src="textBlock.owing_user_image.url"
                class="inline"
              />
              <TextBlockCard :text-block="textBlock" />
            </v-col>
          </v-row>
        </div>
        <!-- /テキストブロック -->
        <ToTopButton />
      </div>
      <div v-else>
        <NotAnyBookmarkBlock prof-message="まだブロックが作成されていないよ" />
      </div>
    </div>
  </div>
</template>

<script>
import axios from "axios";
import TextBlockCard from "../components/text_block/TextBlockCard";
import QuestionBlockCard from "../components/question_block/QuestionBlockCard";
import YesOrNoBlockCard from "../components/yes_or_no_block/YesOrNoBlockCard";
import RankingBlockCard from "../components/ranking_block/RankingBlockCard";
import FavoriteBlockCard from "../components/favorite_block/FavoriteBlockCard";
import NotAnyBookmarkBlock from "../components/others/NotAnyBookmarkBlock";
import Loading from "../components/shared/Loading";
import ToTopButton from "../components/parts/ToTopButton";

export default {
  components: {
    TextBlockCard,
    QuestionBlockCard,
    YesOrNoBlockCard,
    RankingBlockCard,
    FavoriteBlockCard,
    NotAnyBookmarkBlock,
    Loading,
    ToTopButton,
  },
  data() {
    return {
      favoritePopularBlocks: [],
      questionPopularBlocks: [],
      rankingPopularBlocks: [],
      yesOrNoPopularBlocks: [],
      textPopularBlocks: [],
      visible: false,
      loading: true,
    };
  },
  computed: {
    isThereAnyBlock() {
      if (
        this.favoritePopularBlocks.length == 0 &&
        this.questionPopularBlocks.length == 0 &&
        this.rankingPopularBlocks.length == 0 &&
        this.yesOrNoPopularBlocks.length == 0 &&
        this.textPopularBlocks.length == 0
      ) {
        return false;
      } else {
        return true;
      }
    },
  },
  mounted() {
    setTimeout(() => {
      this.loading = false;
    }, 1000);
    this.firstRead();
  },
  created() {
    window.addEventListener("scroll", this.handleScroll);
  },
  destroyed() {
    window.removeEventListener("scroll", this.handleScroll);
  },
  created() {
    document.title = `人気ブロック - プロフちゃん`;
  },
  methods: {
    handleScroll() {
      if (!this.visible) {
        var top = this.$el.getBoundingClientRect().top;
        this.visible = top < window.innerHeight + 100;
      }
    },
    async firstRead() {
      await this.fetchFavoritePopularBlocks();
      await this.fetchQuestionPopularBlocks();
      await this.fetchRankingPopularBlocks();
      await this.fetchYesOrNoPopularBlocks();
      await this.fetchTextPopularBlocks();
    },

    async fetchFavoritePopularBlocks() {
      await axios
        .get("/api/v1/favorite_blocks/popular_blocks")
        .then((res) => (this.favoritePopularBlocks = res.data));
    },
    async fetchQuestionPopularBlocks() {
      await axios
        .get("/api/v1/question_blocks/popular_blocks")
        .then((res) => (this.questionPopularBlocks = res.data));
    },
    async fetchRankingPopularBlocks() {
      await axios
        .get("/api/v1/ranking_blocks/popular_blocks")
        .then((res) => (this.rankingPopularBlocks = res.data));
    },
    async fetchYesOrNoPopularBlocks() {
      await axios
        .get("/api/v1/yes_or_no_blocks/popular_blocks")
        .then((res) => (this.yesOrNoPopularBlocks = res.data));
    },
    async fetchTextPopularBlocks() {
      await axios
        .get("/api/v1/text_blocks/popular_blocks")
        .then((res) => (this.textPopularBlocks = res.data));
    },
  },
};
</script>

<style scoped>
.top {
  color: rgb(77, 77, 77);
}

.top-bg {
  background-color: #efebe9;
  padding: 2rem;
}

.image {
  max-width: 5rem;
}

.border-class {
  background-image: url("data:image/svg+xml,%3csvg width='100%25' height='100%25' xmlns='http://www.w3.org/2000/svg'%3e%3crect width='100%25' height='100%25' fill='none' stroke='white' stroke-width='10' stroke-dasharray='22%2c 22' stroke-dashoffset='0' stroke-linecap='square'/%3e%3c/svg%3e");
}
</style>
