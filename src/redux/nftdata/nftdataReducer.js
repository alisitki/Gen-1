const initialState = {
  loading: false,
  totalSupply: 0,
  cost: 0,
  walletOfOwner: [],
  error: false,
  errorMsg: "",
};

const nftdataReducer = (state = initialState, action) => {
  switch (action.type) {
    case "CHECK_DATA_REQUESTnft":
      return {
        ...state,
        loading: true,
        error: false,
        errorMsg: "",
      };
    case "CHECK_DATA_SUCCESSnft":
      return {
        ...state,
        loading: false,
        walletOfOwner: action.payload.walletOfOwner,
        //totalSupply: action.payload.totalSupply,
        // cost: action.payload.cost,
        error: false,
        errorMsg: "",
      };
    case "CHECK_DATA_FAILEDnft":
      return {
        ...initialState,
        loading: false,
        error: true,
        errorMsg: action.payload,
      };
    default:
      return state;
  }
};

export default nftdataReducer;
