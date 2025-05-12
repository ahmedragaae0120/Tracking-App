import 'package:flutter/material.dart';
import 'package:tracking_app/data/model/orders/order_items.dart';
import 'package:tracking_app/data/model/orders/orders.dart';
import 'package:tracking_app/data/model/orders/product.dart';
import 'package:tracking_app/data/model/orders/store.dart';
import 'package:tracking_app/data/model/orders/user.dart';
import 'package:tracking_app/ui/order_details_screen/view/order_details_screen.dart';
import '../../ui/tabs/home_tab/view/widgets/address_card.dart';
import '../utils/colors_manager.dart';

class CustomFlowerOrder extends StatelessWidget {
  final String price;

  const CustomFlowerOrder({super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    // 👇👇it's just dummy data for testing you have to remove it and pass the real data👇👇
    final order = Orders(
      id: "68150be41433a666c8d91c6c",
      user: User(
        id: "680eb8861433a666c8d66efc",
        firstName: "Elevate",
        lastName: "Tech",
        email: "omar@gmail.com",
        gender: "male",
        phone: "+201010700999",
        photo: "default-profile.png",
      ),
      orderItems: [
        OrderItems(
          id: "68150bd61433a666c8d91c34",
          product: Product(
            id: "673e308c115992017182816d",
            title: "Moko Chocolate Set | Esperance Rose",
            slug: "moko-chocolate-set-or-esperance-rose",
            description:
                "Indulge in the ultimate chocolate experience with the Moko Chocolate Bundle! ...",
            imgCover: "aa6c2099-17db-4e81-85eb-2314cdaf31e8-cover_image.png",
            images: [
              "081c1a80-67ae-4c5a-962b-894c9d32f6db-image_four.png",
              "3a44160e-3a56-4aa5-91ae-b54ceb752f7d-image_one.png",
              "c55c2f05-5d64-4086-b0be-3b383cee3fef-image_three.png",
              "8b2708f3-4384-475e-b4e0-e7368b2a6e2f-image_two.png",
            ],
            price: 1200,
            priceAfterDiscount: 900,
            quantity: 33279,
            category: "673c479e1159920171827c99",
            occasion: "673b39241159920171827b28",
            createdAt: "2024-11-20T18:55:08.188Z",
            updatedAt: "2024-11-20T18:55:08.188Z",
            discount: 50,
            sold: 1055,
            v: 0,
          ),
          price: 1200,
          quantity: 3,
        ),
      ],
      totalPrice: 1800,
      paymentType: "cash",
      isPaid: false,
      isDelivered: false,
      state: "pending",
      createdAt: "2025-05-02T18:16:04.804Z",
      updatedAt: "2025-05-02T18:16:04.804Z",
      orderNumber: "#124722",
      v: 0,
      store: Store(
        name: "Elevate FlowerApp Store",
        image: "https://www.elevateegy.com/elevate.png",
        address: "123 Fixed Address, City, Country",
        phoneNumber: "1234567890",
        latLong: "37.7749,-122.4194",
      ),
    );

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: ColorManager.grey.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Flower order",
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 5),
          const AddressCard(
            title: "Pickup address",
            image: 'https://img.icons8.com/color/48/flower.png',
            subtitle: 'Flowery store',
            address: '20th st, Sheikh Zayed, Giza',
          ),
          const AddressCard(
            title: "User address",
            image: 'https://randomuser.me/api/portraits/women/44.jpg',
            subtitle: 'Nour mohamed',
            address: '20th st, Sheikh Zayed, Giza',
          ),
          Row(
            children: [
              Text(
                "EGP ${price}",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: ColorManager.primaryColor),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    "Reject",
                    style: TextStyle(color: ColorManager.primaryColor),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrderDetailsScreen(
                            // here to give the real data
                            order: order,
                          ),
                        ));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorManager.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    "Accept",
                    style: TextStyle(
                      color: ColorManager.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
