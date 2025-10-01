import { WagmiAdapter } from "@reown/appkit-adapter-wagmi";
import { base,baseSepolia, celo
    
 } from "@reown/appkit/networks";

export const networks = [baseSepolia, base, celo];

export const projectId = "563770c2c39279113e697078705ad8cd";

export const wagmiAdapter = new WagmiAdapter({
	networks,
	projectId,
});
