export const config = {
    google: {
        clientId: Bun.env.GOOGLE_CLIENT_ID ?? "",
        clientSecret: Bun.env.GOOGLE_CLIENT_SECRET ?? "",
        redirectUri: Bun.env.GOOGLE_REDIRECT_URI ?? "",
    },
    jwtSecret: {value: Bun.env.JWT_SECRET ?? "wqpjqjdndoedieffh13943uu9ugwn32n9fivw49jUYOhljt0399fj42hUh230few42rr9uzi",
                expires: Bun.env.JWT_SECRET_EXPIRES ?? "7d"
    } 
}

if (!config.google.clientId){
    throw new Error("MISSING GOOGLE_CLIENT_ID in .env")
}