/** @type {import('next').NextConfig} */
const nextConfig = {
    images:{
        remotePatterns:[
            {
                protocol: "https",
                hostname: "n11scdn.akamaized.net",
            },
            {
                protocol: "https",
                hostname: "i.dummyjson.com",
            },
        ],
    }
}

module.exports = nextConfig
