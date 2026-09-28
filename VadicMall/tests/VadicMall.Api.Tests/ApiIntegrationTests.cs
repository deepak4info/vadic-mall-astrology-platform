using System.Net;
using System.Net.Http.Json;
using System.Text.Json;
using Microsoft.AspNetCore.Mvc.Testing;
using Xunit;

namespace VadicMall.Api.Tests;

public class ApiIntegrationTests : IClassFixture<WebApplicationFactory<Program>>
{
    private readonly HttpClient _client;

    public ApiIntegrationTests(WebApplicationFactory<Program> factory)
    {
        _client = factory.CreateClient();
    }

    [Fact]
    public async Task Health_ReturnsHealthy()
    {
        var response = await _client.GetAsync("/api/health");
        response.EnsureSuccessStatusCode();
        var json = await response.Content.ReadFromJsonAsync<JsonElement>();
        Assert.Equal("healthy", json.GetProperty("status").GetString());
    }

    [Fact]
    public async Task Catalog_ReturnsProducts()
    {
        var products = await _client.GetFromJsonAsync<JsonElement>("/api/catalog/products");
        Assert.True(products.GetArrayLength() > 0);
    }

    [Fact]
    public async Task Auth_Login_Admin_Works()
    {
        var response = await _client.PostAsJsonAsync("/api/auth/login", new
        {
            email = "admin@vadicmall.com",
            password = "Admin@123"
        });

        response.EnsureSuccessStatusCode();
        var json = await response.Content.ReadFromJsonAsync<JsonElement>();
        Assert.False(string.IsNullOrWhiteSpace(json.GetProperty("token").GetString()));
    }

    [Fact]
    public async Task Customer_OrderFlow_Works()
    {
        var login = await _client.PostAsJsonAsync("/api/auth/login", new
        {
            email = "customer@vadicmall.com",
            password = "Customer@123"
        });
        login.EnsureSuccessStatusCode();
        var auth = await login.Content.ReadFromJsonAsync<JsonElement>();
        var token = auth.GetProperty("token").GetString()!;
        _client.DefaultRequestHeaders.Authorization = new("Bearer", token);

        var products = await _client.GetFromJsonAsync<JsonElement>("/api/catalog/products");
        var productId = products[0].GetProperty("id").GetString();

        await _client.DeleteAsync("/api/customer/cart/clear");
        var addCart = await _client.PostAsJsonAsync("/api/customer/cart", new { productId, quantity = 1 });
        addCart.EnsureSuccessStatusCode();

        var order = await _client.PostAsJsonAsync("/api/customer/orders", new { paymentMethod = "UPI" });
        Assert.Equal(HttpStatusCode.OK, order.StatusCode);
        _client.DefaultRequestHeaders.Authorization = null;
    }
}
