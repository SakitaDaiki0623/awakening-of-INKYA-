<template>
  <div>
    <v-card
      class="rounded-2xl pa-5 note-box"
      outlined
      color="cyan lighten-4"
    >
      <v-row
        v-if="isThisEditPage"
        justify="end"
      >
        <v-btn
          :id="'edit-text-block-button-' + textBlock.id"
          tile
          small
          color="cyan lighten-4"
          @click="openEditTextFormatDialog(textBlock)"
        >
          <v-icon> mdi-pencil </v-icon>
        </v-btn>
        <v-btn
          :id="'delete-text-block-button-' + textBlock.id"
          tile
          small
          color="cyan lighten-1"
          @click="hundleDeleteTextBlock(textBlock)"
        >
          <v-icon> mdi-delete </v-icon>
        </v-btn>
      </v-row>
      <v-row v-else>
        <v-spacer />
        <text-block-like-button
          v-if="isThisNotTopPage"
          :text-block-id="textBlock.id"
        />
      </v-row>
      <p class="text-2xl font-bold px-3 pt-3">
        {{ textBlock.title }}
      </p>
      <v-card
        v-if="textBlock.text"
        class="pa-3 rounded-lg"
        outlined
        color="white"
        min-height="200px"
      >
        <div
          v-for="str of textBlock.text.split('\n')"
          :key="str"
        >
          {{ str }}
        </div>
      </v-card>
    </v-card>
    <EditTextFormatDialog
      v-if="isThisEditPage"
      :is-shown-edit-text-format-dialog="isShownEditTextFormatDialog"
      :text-block-color="textBlockColor"
      :edit-text-block="editTextBlock"
      @close-edit-text-format-dialog="closeEditTextFormatDialog"
      @update-text-block="$listeners['update-text-block']"
    />
  </div>
</template>

<script>
import axios from "axios";

import TextBlockLikeButton from "../likes/TextBlockLikeButton";
import EditTextFormatDialog from "./EditTextFormatDialog";

export default {
  components: {
    TextBlockLikeButton,
    EditTextFormatDialog,
  },
  props: {
    textBlock: {
      type: Object,
      requred: true,
    },
    isThisEditPage: {
      type: Boolean,
      required: false,
      default: false,
    },
    textBlockColor: {
      type: String,
      requred: false,
      default: "cyan lighten-3",
    },
  },
  data() {
    return {
      isShownEditTextFormatDialog: false,
      editTextBlock: {},
    };
  },
  computed: {
    isThisNotTopPage() {
      return this.$route.path == `/top` ? false : true;
    },
  },
  methods: {
    openEditTextFormatDialog(textBlock) {
      this.editTextBlock = Object.assign({}, textBlock);
      this.isShownEditTextFormatDialog = true;
    },
    closeEditTextFormatDialog() {
      this.isShownEditTextFormatDialog = false;
    },
    hundleDeleteTextBlock(textBlock) {
      if (!confirm("削除してよろしいですか?")) return;
      this.deleteTextBlock(textBlock);
      this.$store.dispatch("flash/setFlash", {
        type: "success",
        message: "テキストブロックを削除したよ！",
        color: this.textBlockColor,
      });
    },
    deleteTextBlock(textBlock) {
      axios
        .delete(`/api/v1/text_blocks/${textBlock.id}`, textBlock)
        .then((res) => this.$emit("retrieve-text-block", res.data));
    },
  },
};
</script>

<style scoped>
.note-box {
  position: relative;
}

.note-box::after {
  content: "＊*"; /*花に見せかけるためのアスタリスク*/
  color: #fff; /* アスタリスクの色 */
  display: inline-block;
  font-size: 30px; /* アスタリスクの大きさ */
  font-weight: bold;
  position: absolute;
  top: 0px;
  left: 0px;
  transform: rotate(20deg);
  -moz-transform: rotate(20deg);
  -webkit-transform: rotate(20deg);
  -o-transform: rotate(20deg);
  text-shadow: 0px 0px 6px #eaa8bf, 0px 0px 4px #eaa8bf, 0 0 0.5px #eaa8bf; /* アスタリスク周りの影 */
}
</style>
