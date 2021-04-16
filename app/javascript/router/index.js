// app/javascript/router/index.js
import Vue from "vue";
import VueRouter from "vue-router";
import ProfilesPage from "../pages/profile/index";
import ShowProfilesPage from "../pages/profile/show";
import NewProfilesPage from "../pages/profile/new";
import EditProfilesPage from "../pages/profile/edit";

Vue.use(VueRouter);

const routes = [
  {
    path: "/profiles/new",
    name: "NewProfilesPage",
    component: NewProfilesPage,
  },
  {
    path: "/profiles",
    name: "ProfilesPage",
    component: ProfilesPage,
  },
  {
    path: "/profiles/:id(\\d+)",
    name: "ShowProfilesPage",
    component: ShowProfilesPage,
    props: true
  },
  {
    path: "/profiles/:id(\\d+)/edit",
    name: "EditProfilesPage",
    component: EditProfilesPage,
    props: true
  },
];

const router = new VueRouter({ mode: "history", routes });

export default router;