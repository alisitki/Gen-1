import React, {useEffect, useState} from "react";
import { useDispatch, useSelector } from "react-redux";
import { connect } from "./redux/blockchain/blockchainActions";
import { fetchData } from "./redux/data/dataActions";
import { nftfetchData } from "./redux/nftdata/nftdataActions";
import { FullScreen, useFullScreenHandle } from "react-full-screen"; 
import * as s from "./styles/globalStyles";
import styled from "styled-components";
import "./styles/reset.css";
let qq=0;
let arr = [];
function App() {
  const dispatch = useDispatch();
  const blockchain = useSelector((state) => state.blockchain);
  const data = useSelector((state) => state.data);
  const nftdata = useSelector((state) => state.nftdata);
  const [claimingNft, setClaimingNft] = useState(false);
  const [added, setadded] = useState(false);
  const [svg,setSvg] = useState("");
  const [hook,setHook] = useState("");  
  const [CONFIG, SET_CONFIG] = useState({
    CONTRACT_ADDRESS: "",
    SCAN_LINK: "",
    NETWORK: {
      NAME: "",
      SYMBOL: "",
      ID: 0,
    },
    NFT_NAME: "",
    SYMBOL: "",
    MAX_SUPPLY: 1,
    WEI_COST: 0,
    DISPLAY_COST: 0,
    GAS_LIMIT: 0,
    MARKETPLACE: "",
    MARKETPLACE_LINK: "",
    SHOW_BACKGROUND: false,
  });
  const generate = () => {
   if( blockchain.account === "" || blockchain.smartContract === null){
    //setFeedback("connect"); 
   }else{
    let cost = CONFIG.WEI_COST;
    let totalCostWei = String(cost);
    setClaimingNft(true);
    blockchain.smartContract.methods
      .generate()
      .send({
        to: CONFIG.CONTRACT_ADDRESS,
        from: blockchain.account,
         value: totalCostWei,
      })
      .once("error", (err) => {
        console.log(err);
        setClaimingNft(false);
      })
      .then((receipt) => {
        setadded(true);
        console.log(receipt);
        setClaimingNft(false);
        dispatch(fetchData(blockchain.account));
      });
   }
  };
  const tokenURI = (tokenNo) => {
    //console.log(tokenNo);
    if( blockchain.account === "" || blockchain.smartContract === null){
     //setFeedback("connect");
    }else{       
        blockchain.smartContract.methods
       .tokenURI(tokenNo)
       .call()
       .then(result =>{
        setHook(result) 
        const json = Buffer.from(result.substring(29), "base64").toString();
        var result2 = json.split('"name": "')[1];
        result2 = result2.slice(0, -(result2.length-6)); 
        //console.log(result2);
        arr[tokenNo]='name: '+result2;
     })
    }
   };

  const getData = () => {
    if (blockchain.account !== "" && blockchain.smartContract !== null) {
      dispatch(fetchData(blockchain.account));
    }
  };
  const getDataz = () => {
    if (blockchain.account !== "" && blockchain.smartContract !== null) {
      dispatch(nftfetchData(blockchain.account));
    }
  };
  const getConfig = async () => {
    const configResponse = await fetch("/config/config.json", {
      headers: {
        "Content-Type": "application/json",
        Accept: "application/json",
      },
    });
    const config = await configResponse.json();
    SET_CONFIG(config);
  };  
  const cconnect = () => {
    //setFeedback("");
    dispatch(connect());
    getData();
  }
    useEffect(() => {
      getConfig();
    });
    useEffect(() => {
      getData();
    }, [blockchain.account]);

    const contract = () => {

      window.open("https://snowtrace.io/address/0xDaf8b70eb6e7adE3AdACbFe47B25959b26eAd76D", "_blank")

    }

    const handle =  useFullScreenHandle();
    const openAs = (hook) => {
      if(hook !== ""){
          const json = Buffer.from(hook.substring(29), "base64").toString();
          var result = json.split('"image": "')[1]; 
          result = result.slice(0, -2); 
          console.log(result);
          setSvg(result);
          handle.enter();
        }
    }
    useEffect(() => {  
      openAs(hook);
      setHook("");
    },[hook]);
    useEffect(() => {
      getDataz();
      setadded(false);   
    }, [blockchain.account,added]);
  window.addEventListener("contextmenu", e => e.preventDefault());
  return (
        <s.Screen >
            <Console>
              <FullScreen handle={handle}>{handle.active === true ? <SvgSec src={svg}/>:null}</FullScreen>
              <MsjText>Project-Gen</MsjText>
              <s.SpacerMedium/>
              <s.SpacerMedium/>
              <MsjText2>Gen-1 Generator</MsjText2>
              <s.SpacerMedium/>
              <PriceText  >Price: 7 Avax</PriceText>
              <s.SpacerMedium/>
              {blockchain.account === "" ||
                     blockchain.smartContract === null ? (null) 
                     :
                  (<><Divy><SupplyText>{data.totalSupply} / 777</SupplyText><s.SpacerXSmall/><ContractAd style={{cursor: 'pointer'}} onClick={contract}>contract</ContractAd></Divy></>) }
              <s.SpacerMedium/>
              {blockchain.account === "" ||
                     blockchain.smartContract === null ? <Connecttext onClick={cconnect}>Connect</Connecttext>
                    :
                    claimingNft === false ? 
                      data.totalSupply < CONFIG.MAX_SUPPLY ? 
                        <Connecttext onClick={generate}>Generate</Connecttext> 
                          :
                        <Connecttext style={{color:'red',cursor: 'default'}}  >Generation Completed</Connecttext> 
                    : 
                      data.totalSupply < CONFIG.MAX_SUPPLY ?
                        <Connecttext style={{color:'#bccad6',cursor: 'default'}} >Generating</Connecttext>    
                        :
                        <Connecttext style={{color:'red',cursor: 'default'}} >Generation Completed</Connecttext> }
              <s.SpacerMedium/>
              {blockchain.account === "" || blockchain.smartContract === null ? (null):
                    (<><s.SpacerMedium/>
                    <CollectionsText>collections</CollectionsText>
                    <s.SpacerMedium/><s.SpacerMedium/></>)}                  
              {blockchain.account === "" || blockchain.smartContract === null ? (null):(                
              <><Divx >
                {nftdata.walletOfOwner.length > 0 ? Array.from({ length: nftdata.walletOfOwner.length }, (_, qq) =>  
                <Divx key={qq}> 
                    <Assette  onClick={() => tokenURI(Number(nftdata.walletOfOwner[qq]))}  >no:{nftdata.walletOfOwner[qq]}&nbsp;-&nbsp;{arr[nftdata.walletOfOwner[qq]]}</Assette>
                </Divx>)   
                :
                <Divx key={qq}>
                    <Empty >empty</Empty>                   
                </Divx> 
                }
              </Divx> </>)}
            </Console>
        </s.Screen>
  );
}

export default App;

const SvgSec = styled.img`
      background-color:  black;
      height: 100vh;
      width: 100vw;
      transition: width 0.5s;
      transition: height 0.5s;
`;

const MsjText = styled.p`
    color:white;
    font-size : 6vw;
  
    `;
const MsjText2 = styled.p`
    color:white;
    font-size : 3vw;
`;
const ContractAd = styled.p`
    color:white;
    font-size : 1.3vw;
    font-weight: 400; 
`;
const PriceText = styled.p`
    color:white;
    font-size : 3vw;
`;
const CollectionsText = styled.p`
    color:white;
    font-size : 2.5vw;
`;
const SupplyText = styled.p`
    color:white;
    font-size : 2vw;
    font-weight: 400; 
`;
const Assette = styled.p`
    color:white;
    font-size : 1.5vw;
    font-weight: 500; 
    text-Decoration-Line: underline;
    cursor: pointer;
    :hover {
      color:#e0e2e4;
      }
    
`;
const Empty = styled.p`
    color:white;
    font-size : 1.5vw;
    font-weight: 500;     
`;
const Connecttext = styled.p`
    color:white;
    font-size : 4vw;
    text-Decoration-Line: underline;
    cursor: pointer;
    :hover {
      color:#e0e2e4;
      }
      
      
`;
const Console = styled.section`
    background-color:  black;    

    height:100vh;

    font-family: 'Hahmlet', serif;
    font-weight: 200; 
    
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
`;
const Divx = styled.section`
    background-color: black;
    width:100%;
    display:grid;
    grid-template-columns: auto auto auto;
    grid-column-gap: 50px;
    grid-gap: 30px 80px;
    grid-column-start: 3;
    grid-column-end: 30;
    justify-content: center;

`;
const Divy = styled.section`
background-color: black;
    width:100%;
    display:grid;
    grid-template-columns: auto auto auto;
    grid-column-gap: 10px;
    grid-gap: 10px 10px;
    grid-column-start: 1;
    grid-column-end: 2;
    justify-content: center;

`;