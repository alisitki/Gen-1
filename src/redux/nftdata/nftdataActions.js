import store from "../store";
const fetchDataRequestnft = () => {
  return {
    type: "CHECK_DATA_REQUESTnft",
  };
};
const fetchDataSuccessnft = (payload) => {
  return {
    type: "CHECK_DATA_SUCCESSnft",
    payload: payload,
  };
};
const fetchDataFailednft = (payload) => {
  return {
    type: "CHECK_DATA_FAILEDnft",
    payload: payload,
  };
};
export const nftfetchData = () => {
  return async (dispatch) => {
    dispatch(fetchDataRequestnft());    
    try {      
      let walletOfOwner = await store
        .getState()
        .blockchain.smartContract.methods.owned_gens(await store
          .getState()
          .blockchain.account)
        .call();
      dispatch(
        fetchDataSuccessnft({
          walletOfOwner,
        })
      );
    } catch (err) {
      console.log(err);
      dispatch(fetchDataFailednft("Could not load data from contract."));
    }
  };
};
