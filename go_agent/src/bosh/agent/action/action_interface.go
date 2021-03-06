package action

type Action interface {
	IsAsynchronous() bool

	// Action should implement Run
	// Arguments should be the list of arguments the payload will include
	// and necessary for running the action
	//
	// It should return:
	//	* a value, used as the response value. It will be converted to JSON
	//	* an error, used to return an error response instead
	//
	// Run(...) (value interface{}, err error)
	//
	// See Runner for more details
}
