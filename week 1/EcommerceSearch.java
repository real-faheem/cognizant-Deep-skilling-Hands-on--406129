// EcommerceSearch.java

import java.util.Arrays;

class Product implements Comparable<Product> {
    int productId;
    String productName;
    String category;

    public Product(int productId, String productName, String category) {
        this.productId = productId;
        this.productName = productName;
        this.category = category;
    }

    public String toString() {
        return "ID: " + productId + ", Name: " + productName + ", Category: " + category;
    }

    @Override
    public int compareTo(Product other) {
        return this.productId - other.productId;
    }
}

public class EcommerceSearch {

    // Linear search by productId
    public static Product linearSearch(Product[] products, int id) {
        for (Product p : products) {
            if (p.productId == id) return p;
        }
        return null;
    }

    // Binary search by productId (assumes sorted array)
    public static Product binarySearch(Product[] products, int id) {
        int left = 0, right = products.length - 1;
        while (left <= right) {
            int mid = (left + right) / 2;
            if (products[mid].productId == id)
                return products[mid];
            else if (products[mid].productId < id)
                left = mid + 1;
            else
                right = mid - 1;
        }
        return null;
    }

    public static void main(String[] args) {
        Product[] products = {
            new Product(101, "Phone", "Electronics"),
            new Product(203, "Shoes", "Footwear"),
            new Product(302, "Watch", "Accessories"),
            new Product(150, "Laptop", "Electronics")
        };

        System.out.println("Linear Search:");
        Product result1 = linearSearch(products, 203);
        System.out.println(result1 != null ? result1 : "Product not found");

        // Sort before binary search
        Arrays.sort(products);

        System.out.println("\nBinary Search:");
        Product result2 = binarySearch(products, 203);
        System.out.println(result2 != null ? result2 : "Product not found");
    }
}

// Big O Notation (Asymptotic Analysis)

//Describes how algorithm performance scales with input size n.
//Linear Search: O(n) – scans each item one-by-one.
//Binary Search: O(log n) – divides search space in half each step.


//Which Is Better?

//Binary Search is faster, but needs a sorted array.
//Linear Search works on unsorted data but is slower on large datasets.
//For e-commerce where product lists are often sorted by ID or relevance, binary search is ideal.
