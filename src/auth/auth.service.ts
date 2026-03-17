import { randomId } from "elysia/dist/utils";
import db from "../db";

export function getGoogleUrl() {
    const params = new URLSearchParams({
        client_id: Bun.env.GOOGLE_CLIENT_ID!,
        redirect_uri: Bun.env.GOOGLE_REDIRECT_URI!,
        response_type: "code",
        scope: "email profile",
    })

    return `https://accounts.google.com/o/oauth2/v2/auth?${params}`
}

export async function exchangeCodeForTokens(code: string) {
    const response = await fetch("https://oauth2.googleapis.com/token",
        {
            method: "POST",
            headers: { "Content-Type": "application/x-www-form-urlencoded" },
            body: new URLSearchParams({
                code: code,
                client_id: Bun.env.GOOGLE_CLIENT_ID!,
                client_secret: Bun.env.GOOGLE_CLIENT_SECRET!,
                redirect_uri: Bun.env.GOOGLE_REDIRECT_URI!,
                grant_type: "authorization_code",
            })
        })

    return response.json()
}

export async function getGoogleUser(accessToken: string) {
    const response = await fetch("https://www.googleapis.com/oauth2/v2/userinfo",
        {
            method: "GET",
            headers: { "Authorization": `Bearer ${accessToken}` },
        }
    )
    return response.json()
}

function genUserName(email: string) {
    const domain = email.split("@")[0];
    return domain.concat(randomId())
}

export async function findOrCreateUser(googleUser: { id: string, email: string, name: string, picture: string }) {
    let user = await db.user.findUnique({ where: { googleId: googleUser.id } })

    if (!user) {
        user = await db.user.create({
            data: {
                googleId: googleUser.id,
                email: googleUser.email,
                fullname: googleUser.name,
                username: genUserName(googleUser.email),
                picture: googleUser.picture,
            }
        })
    } else {
        await db.user.update({ where: { id: user.id }, data: { lastLoginAt: new Date() } })
    }
    return user
}