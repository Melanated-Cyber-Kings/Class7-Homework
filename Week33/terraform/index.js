exports.handler = async (event) => {
    const response = {
        statusCode: 200,
        body: JSON.stringify('Hello from the Node Lambda managed by Terraform!'),
    };
    return response;
};
