import { Elysia } from "elysia";
import { exchangeCodeForTokens, findOrCreateUser, getGoogleUrl, getGoogleUser } from "./auth.service";

export const authRoutes = new Elysia({prefix: "/auth"})
.get("/google", ({redirect})=>{
    return redirect(getGoogleUrl())})
.get("/google/callback", async ({query})=>{
    const code = query.code
    const tokens = await exchangeCodeForTokens(code)
    const googleUser = await getGoogleUser(tokens.access_token)
    const user = await findOrCreateUser(googleUser)

    return user
})